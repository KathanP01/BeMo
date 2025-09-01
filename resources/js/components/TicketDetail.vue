<template>
  <div class="ticket-detail">
    <!-- Header with Back Button -->
    <div class="detail-header">
      <button class="back-btn" @click="$router.back()">
        <span class="back-icon">←</span>
        Back to Tickets
      </button>
      <h1 class="detail-title">Ticket Details</h1>
      <div class="header-actions">
        <button class="btn btn--secondary" @click="classifyTicket" :disabled="classifying">
          <span v-if="classifying" class="loading"></span>
          {{ classifying ? 'Classifying...' : '🤖 AI Classify' }}
        </button>
      </div>
    </div>

    <div v-if="loading" class="loading-state">
      <div class="loading-spinner"></div>
      <p>Loading ticket details...</p>
    </div>
    
    <div v-else-if="ticket" class="ticket-detail__content">
      <!-- Main Ticket Card -->
      <div class="detail-card">
        <div class="card-header">
          <div class="ticket-meta">
            <span :class="['status-badge', `status-badge--${ticket.status}`]">
              {{ ticket.status }}
            </span>
            <span class="ticket-id">#{{ String(ticket.id).substring(0, 8) }}</span>
            <span class="ticket-date">Created {{ formatDate(ticket.created_at) }}</span>
          </div>
          <div class="ai-info" v-if="ticket.confidence">
            <span class="ai-badge" title="AI Classified">🤖 AI</span>
            <span class="confidence-badge" :title="ticket.explanation">
              {{ (ticket.confidence * 100).toFixed(0) }}% confident
            </span>
          </div>
        </div>

        <div class="ticket-content">
          <h2 class="ticket-subject">{{ ticket.subject }}</h2>
          <div class="ticket-body">
            <h3 class="body-label">Description</h3>
            <p class="body-text">{{ ticket.body }}</p>
          </div>
        </div>

        <div class="ticket-stats">
          <div class="stat-item">
            <span class="stat-label">Category</span>
            <span class="stat-value">{{ ticket.category || 'Not classified' }}</span>
          </div>
          <div class="stat-item" v-if="ticket.confidence">
            <span class="stat-label">AI Confidence</span>
            <span class="stat-value confidence-value">
              {{ (ticket.confidence * 100).toFixed(0) }}%
            </span>
          </div>
          <div class="stat-item" v-if="ticket.explanation">
            <span class="stat-label">AI Explanation</span>
            <span class="stat-value explanation">{{ ticket.explanation }}</span>
          </div>
        </div>
      </div>

      <!-- Update Form Card -->
      <div class="detail-card">
        <h3 class="card-title">Update Ticket</h3>
        
        <div class="form-grid">
          <div class="form-group">
            <label class="form-label">Status</label>
            <select class="form-select" v-model="updateData.status">
              <option value="open">Open</option>
              <option value="pending">Pending</option>
              <option value="resolved">Resolved</option>
            </select>
          </div>

          <div class="form-group">
            <label class="form-label">Category</label>
            <select class="form-select" v-model="updateData.category">
              <option value="">Select category</option>
              <option value="Billing">Billing</option>
              <option value="Technical">Technical</option>
              <option value="Feature Request">Feature Request</option>
              <option value="General Inquiry">General Inquiry</option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label">
            Internal Notes
            <span class="label-hint">(Only visible to support team)</span>
          </label>
          <textarea 
            class="form-textarea" 
            v-model="updateData.note" 
            placeholder="Add internal notes, observations, or follow-up actions..."
            rows="4"
          ></textarea>
        </div>

        <div class="form-actions">
          <button class="btn btn--primary" @click="updateTicket" :disabled="updating">
            <span v-if="updating" class="loading"></span>
            {{ updating ? 'Updating...' : 'Update Ticket' }}
          </button>
          
          <button class="btn btn--outline" @click="classifyTicket" :disabled="classifying">
            <span v-if="classifying" class="loading"></span>
            {{ classifying ? 'Classifying...' : 'Re-classify with AI' }}
          </button>
        </div>

        <div v-if="ticket.note" class="existing-notes">
          <h4 class="notes-title">Existing Notes</h4>
          <div class="notes-content">
            <p>{{ ticket.note }}</p>
            <span class="notes-date">Last updated: {{ formatDate(ticket.updated_at) }}</span>
          </div>
        </div>
      </div>

      <!-- Activity Log (Optional) -->
      <div class="detail-card">
        <h3 class="card-title">Activity Log</h3>
        <div class="activity-list">
          <div class="activity-item">
            <div class="activity-icon">📝</div>
            <div class="activity-content">
              <p>Ticket created</p>
              <span class="activity-date">{{ formatDate(ticket.created_at) }}</span>
            </div>
          </div>
          <div class="activity-item" v-if="ticket.confidence">
            <div class="activity-icon">🤖</div>
            <div class="activity-content">
              <p>AI classification completed</p>
              <span class="activity-date">{{ formatDate(ticket.updated_at) }}</span>
            </div>
          </div>
          <div class="activity-item" v-if="ticket.note">
            <div class="activity-icon">💬</div>
            <div class="activity-content">
              <p>Internal note added</p>
              <span class="activity-date">{{ formatDate(ticket.updated_at) }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="error-state">
      <div class="error-icon">❌</div>
      <h3>Ticket not found</h3>
      <p>The requested ticket could not be loaded.</p>
      <button class="btn btn--primary" @click="$router.push('/tickets')">Back to Tickets</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'TicketDetail',
  props: ['id'],
  data() {
    return {
      ticket: null,
      loading: true,
      updating: false,
      classifying: false,
      updateData: {
        status: '',
        category: '',
        note: ''
      }
    }
  },
  watch: {
    ticket: {
      immediate: true,
      handler(newTicket) {
        if (newTicket) {
          this.updateData = {
            status: newTicket.status,
            category: newTicket.category || '',
            note: newTicket.note || ''
          };
        }
      }
    }
  },
  async mounted() {
    await this.fetchTicket();
  },
  methods: {
    async fetchTicket() {
      this.loading = true;
      try {
        const response = await fetch(`/api/tickets/${this.id}`);
        if (response.ok) {
          this.ticket = await response.json();
        } else {
          console.error('Error fetching ticket:', response.status);
        }
      } catch (error) {
        console.error('Error fetching ticket:', error);
      }
      this.loading = false;
    },
    
    async updateTicket() {
      this.updating = true;
      try {
        const response = await fetch(`/api/tickets/${this.id}`, {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(this.updateData)
        });
        
        if (response.ok) {
          this.ticket = await response.json();
          this.showNotification('Ticket updated successfully!', 'success');
        } else {
          const error = await response.json();
          this.showNotification('Error updating ticket: ' + JSON.stringify(error), 'error');
        }
      } catch (error) {
        console.error('Error updating ticket:', error);
        this.showNotification('Error updating ticket', 'error');
      }
      this.updating = false;
    },
    
    async classifyTicket() {
      this.classifying = true;
      try {
        const response = await fetch(`/api/tickets/${this.id}/classify`, {
          method: 'POST'
        });
        
        if (response.ok) {
          this.showNotification('AI classification started...', 'info');
          setTimeout(async () => {
            await this.fetchTicket();
            this.classifying = false;
            this.showNotification('Ticket classification completed!', 'success');
          }, 2000);
        } else {
          this.showNotification('Error classifying ticket', 'error');
          this.classifying = false;
        }
      } catch (error) {
        console.error('Error classifying ticket:', error);
        this.showNotification('Error classifying ticket', 'error');
        this.classifying = false;
      }
    },
    
    formatDate(dateString) {
      if (!dateString) return '';
      const date = new Date(dateString);
      return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      });
    },
    
    showNotification(message, type = 'info') {
      // Simple notification - you can replace with a proper toast library
      alert(`${type.toUpperCase()}: ${message}`);
    }
  }
}
</script>

<style scoped>
.ticket-detail {
  padding: 20px;
  max-width: 1000px;
  margin: 0 auto;
}

/* Header */
.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
}

.back-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  border: 1px solid #e2e8f0;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
  font-weight: 500;
}

.back-btn:hover {
  background: #f7fafc;
  border-color: #cbd5e0;
}

.back-icon {
  font-size: 1.2rem;
}

.detail-title {
  font-size: 1.8rem;
  font-weight: 700;
  color: #2d3748;
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 1rem;
}

/* Cards */
.detail-card {
  background: white;
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
  margin-bottom: 1.5rem;
  border: 1px solid #e2e8f0;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e2e8f0;
}

.ticket-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.status-badge {
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
  text-transform: uppercase;
}

.status-badge--open {
  background: #fed7d7;
  color: #c53030;
}

.status-badge--pending {
  background: #feebcb;
  color: #c05621;
}

.status-badge--resolved {
  background: #c6f6d5;
  color: #2f855a;
}

.ticket-id {
  font-size: 0.9rem;
  color: #718096;
  font-weight: 500;
}

.ticket-date {
  font-size: 0.9rem;
  color: #a0aec0;
}

.ai-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.ai-badge {
  background: #ebf8ff;
  padding: 0.4rem 0.8rem;
  border-radius: 16px;
  font-size: 0.8rem;
  color: #2b6cb0;
  font-weight: 600;
}

.confidence-badge {
  background: #c6f6d5;
  padding: 0.4rem 0.8rem;
  border-radius: 16px;
  font-size: 0.8rem;
  color: #2f855a;
  font-weight: 600;
}

/* Ticket Content */
.ticket-content {
  margin-bottom: 2rem;
}

.ticket-subject {
  font-size: 1.5rem;
  font-weight: 700;
  color: #2d3748;
  margin: 0 0 1.5rem 0;
  line-height: 1.4;
}

.ticket-body {
  background: #f7fafc;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #4299e1;
}

.body-label {
  font-weight: 600;
  color: #4a5568;
  margin: 0 0 1rem 0;
  font-size: 1.1rem;
}

.body-text {
  color: #2d3748;
  line-height: 1.6;
  margin: 0;
  white-space: pre-wrap;
}

/* Stats */
.ticket-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  padding: 1.5rem;
  background: #f7fafc;
  border-radius: 8px;
}

.stat-item {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.stat-label {
  font-weight: 600;
  color: #4a5568;
  font-size: 0.9rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.stat-value {
  color: #2d3748;
  font-weight: 500;
}

.confidence-value {
  background: #ebf8ff;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  color: #2b6cb0;
  font-weight: 600;
  display: inline-block;
}

.explanation {
  font-style: italic;
  color: #718096;
}

/* Form */
.card-title {
  font-size: 1.3rem;
  font-weight: 600;
  color: #2d3748;
  margin: 0 0 1.5rem 0;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
  margin-bottom: 1.5rem;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #2d3748;
}

.label-hint {
  font-weight: normal;
  color: #718096;
  font-size: 0.9rem;
}

.form-select,
.form-textarea {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.2s ease;
}

.form-select:focus,
.form-textarea:focus {
  outline: none;
  border-color: #4299e1;
}

.form-textarea {
  min-height: 120px;
  resize: vertical;
}

.form-actions {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
}

.btn--outline {
  background: white;
  border: 2px solid #e2e8f0;
  color: #4a5568;
}

.btn--outline:hover {
  background: #f7fafc;
  border-color: #cbd5e0;
}

/* Existing Notes */
.existing-notes {
  background: #f0fff4;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #48bb78;
}

.notes-title {
  font-weight: 600;
  color: #2f855a;
  margin: 0 0 1rem 0;
  font-size: 1.1rem;
}

.notes-content {
  color: #2d3748;
  line-height: 1.6;
}

.notes-date {
  font-size: 0.85rem;
  color: #718096;
  font-style: italic;
}

/* Activity Log */
.activity-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.activity-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1rem;
  background: #f7fafc;
  border-radius: 8px;
}

.activity-icon {
  font-size: 1.2rem;
  padding: 0.5rem;
  background: white;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.activity-content p {
  margin: 0 0 0.25rem 0;
  font-weight: 500;
  color: #2d3748;
}

.activity-date {
  font-size: 0.85rem;
  color: #718096;
}

/* Loading State */
.loading-state {
  text-align: center;
  padding: 4rem 2rem;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #e2e8f0;
  border-top: 4px solid #4299e1;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem;
}

.loading-state p {
  color: #718096;
  font-size: 1.1rem;
}

/* Error State */
.error-state {
  text-align: center;
  padding: 4rem 2rem;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
}

.error-icon {
  font-size: 4rem;
  margin-bottom: 1.5rem;
}

.error-state h3 {
  color: #e53e3e;
  margin: 0 0 1rem 0;
  font-size: 1.5rem;
}

.error-state p {
  color: #718096;
  margin: 0 0 2rem 0;
  font-size: 1.1rem;
}

/* Animations */
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Responsive Design */
@media (max-width: 768px) {
  .detail-header {
    flex-direction: column;
    gap: 1rem;
    text-align: center;
  }
  
  .ticket-meta {
    justify-content: center;
  }
  
  .ai-info {
    justify-content: center;
  }
  
  .form-grid {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .ticket-stats {
    grid-template-columns: 1fr;
  }
  
  .card-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
}
</style>