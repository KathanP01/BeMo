<template>
  <div class="ticket-list">
    <!-- Header Section -->
    <div class="ticket-list__header">
      <div class="header-content">
        <h1 class="header-title">
          <span class="icon">🎫</span>
          Support Tickets
          <span class="badge badge--primary">{{ tickets.total || 0 }}</span>
        </h1>
        <p class="header-subtitle">Manage and track all support requests</p>
      </div>
      <button class="btn btn--primary btn--with-icon" @click="showModal = true">
        <span class="icon">+</span>
        New Ticket
      </button>
    </div>

    <!-- Filters Section -->
    <div class="filters-section">
      <div class="filters-grid">
        <div class="filter-group">
          <label class="filter-label">Status</label>
          <select class="filter-select" v-model="filters.status" @change="fetchTickets">
            <option value="all">All Statuses</option>
            <option value="open">Open</option>
            <option value="pending">Pending</option>
            <option value="resolved">Resolved</option>
          </select>
        </div>
        
        <div class="filter-group">
          <label class="filter-label">Category</label>
          <select class="filter-select" v-model="filters.category" @change="fetchTickets">
            <option value="all">All Categories</option>
            <option v-for="category in categories" :value="category">{{ category }}</option>
          </select>
        </div>
        
        <div class="filter-group filter-group--search">
          <label class="filter-label">Search</label>
          <div class="search-input-wrapper">
            <span class="search-icon">🔍</span>
            <input 
              type="text" 
              class="search-input" 
              v-model="filters.search" 
              placeholder="Search tickets..." 
              @input="onSearchInput"
            >
          </div>
        </div>
        
        <div class="filter-group">
          <label class="filter-label">Items per page</label>
          <select class="filter-select" v-model="perPage" @change="fetchTickets(1)">
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
          </select>
        </div>
      </div>
    </div>

    <!-- Tickets Grid -->
    <div class="tickets-grid" v-if="tickets.data && tickets.data.length > 0">
      <div class="ticket-card" v-for="ticket in tickets.data" :key="ticket.id" :class="`ticket-card--${ticket.status}`">
        <div class="ticket-card__header">
          <div class="ticket-id">#{{ String(ticket.id).substring(0, 8) }}</div>
          <span :class="['status-badge', `status-badge--${ticket.status}`]">
            {{ ticket.status }}
          </span>
        </div>
        
        <div class="ticket-card__content">
          <h3 class="ticket-subject">{{ ticket.subject }}</h3>
          <p class="ticket-body">{{ truncateText(ticket.body, 120) }}</p>
          
          <div class="ticket-meta">
            <div class="meta-item">
              <span class="meta-label">Category:</span>
              <span class="meta-value">{{ ticket.category || 'Not classified' }}</span>
            </div>
            <div class="meta-item" v-if="ticket.confidence">
              <span class="meta-label">Confidence:</span>
              <span class="meta-value confidence-value" :title="ticket.explanation">
                {{ (ticket.confidence * 100).toFixed(0) }}%
              </span>
            </div>
          </div>
        </div>
        
        <div class="ticket-card__footer">
          <div class="ticket-actions">
            <button class="btn btn--secondary btn--small" @click="$router.push(`/tickets/${ticket.id}`)">
              View Details
            </button>
            <button 
              class="btn btn--primary btn--small" 
              @click="classifyTicket(ticket)" 
              :disabled="classifyingTicket === ticket.id"
              :title="ticket.category ? 'Re-classify with AI' : 'Classify with AI'"
            >
              <span v-if="classifyingTicket === ticket.id" class="loading"></span>
              <span v-else>🤖 AI</span>
            </button>
          </div>
          <div class="ticket-date">
            Created {{ formatDate(ticket.created_at) }}
          </div>
        </div>
        
        <div class="ticket-indicators">
          <span v-if="ticket.note" class="indicator indicator--note" title="Has internal note">📝</span>
          <span v-if="ticket.confidence" class="indicator indicator--ai" title="AI Classified">🤖</span>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div class="empty-state" v-else>
      <div class="empty-state__icon">🎫</div>
      <h3 class="empty-state__title">No tickets found</h3>
      <p class="empty-state__message">Try adjusting your filters or create a new ticket to get started.</p>
      <button class="btn btn--primary" @click="showModal = true">Create First Ticket</button>
    </div>

    <!-- Pagination -->
     <div class="pagination" v-if="tickets.data && tickets.data.length > 0 && tickets.meta">
      <div class="pagination-info">
        Showing {{ ((currentPage - 1) * perPage) + 1 }} to 
        {{ Math.min(currentPage * perPage, tickets.meta.total) }} of 
        {{ tickets.meta.total }} tickets
      </div>
      <div class="pagination-controls">
        <button 
          class="pagination-btn" 
          @click="goToPage(currentPage - 1)" 
          :disabled="currentPage === 1"
        >
          ← Previous
        </button>
        
        <div class="pagination-pages">
          <button 
            v-for="page in pages" 
            :key="page" 
            @click="goToPage(page)"
            :class="['pagination-page', { 'pagination-page--active': currentPage === page }]"
          >
            {{ page }}
          </button>
        </div>
        
        <button 
          class="pagination-btn" 
          @click="goToPage(currentPage + 1)" 
          :disabled="currentPage === totalPages"
        >
          Next →
        </button>
      </div>
    </div>

    <!-- New Ticket Modal -->
    <div v-if="showModal" class="modal">
      <div class="modal__content">
        <div class="modal__header">
          <h2>Create New Support Ticket</h2>
          <button class="modal__close" @click="showModal = false">&times;</button>
        </div>
        <form @submit.prevent="createTicket">
          <div class="form-group">
            <label class="form-label">Subject *</label>
            <input type="text" class="form-input" v-model="newTicket.subject" required placeholder="Brief description of the issue">
          </div>
          <div class="form-group">
            <label class="form-label">Description *</label>
            <textarea class="form-textarea" v-model="newTicket.body" required placeholder="Detailed description of the problem..." rows="4"></textarea>
          </div>
          <div class="modal__footer">
            <button type="button" class="btn btn--secondary" @click="showModal = false">Cancel</button>
            <button type="submit" class="btn btn--primary" :disabled="creatingTicket">
              <span v-if="creatingTicket" class="loading"></span>
              {{ creatingTicket ? 'Creating...' : 'Create Ticket' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'TicketList',
  data() {
    return {
      tickets: { data: [] },
      filters: {
        status: 'all',
        category: 'all',
        search: ''
      },
      categories: ['Billing', 'Technical', 'Feature Request', 'General Inquiry'],
      showModal: false,
      newTicket: {
        subject: '',
        body: ''
      },
      creatingTicket: false,
      classifyingTicket: null,
      currentPage: 1,
      perPage: 10,
      searchTimeout: null
    }
  },
  computed: {
    pages() {
      if (!this.tickets.meta || !this.tickets.meta.last_page) return [];
      const pages = [];
      const totalPages = this.tickets.meta.last_page;
      const maxVisiblePages = 5;
      let startPage = Math.max(1, this.currentPage - Math.floor(maxVisiblePages / 2));
      let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);
      
      if (endPage - startPage + 1 < maxVisiblePages) {
        startPage = Math.max(1, endPage - maxVisiblePages + 1);
      }
      
      for (let i = startPage; i <= endPage; i++) {
        pages.push(i);
      }
      return pages;
    },
    totalPages() {
      return this.tickets.meta?.last_page || 1;
    }
  },
  mounted() {
    this.fetchTickets();
  },
  methods: {
    async fetchTickets(page = 1) {
      try {
        const params = new URLSearchParams();
        if (this.filters.status !== 'all') params.append('status', this.filters.status);
        if (this.filters.category !== 'all') params.append('category', this.filters.category);
        if (this.filters.search) params.append('search', this.filters.search);
        params.append('page', page);
        params.append('per_page', this.perPage);
        
        const response = await fetch(`/api/tickets?${params}`);
        const data = await response.json();
        
        this.tickets = {
          data: data.data || [],
          meta: {
            current_page: data.current_page || 1,
            last_page: data.last_page || 1,
            per_page: data.per_page || this.perPage,
            total: data.total || 0,
            from: data.from || 0,
            to: data.to || 0
          }
        };
        
        this.currentPage = page;
      } catch (error) {
        console.error('Error fetching tickets:', error);
      }
    },
    
    onSearchInput() {
      clearTimeout(this.searchTimeout);
      this.searchTimeout = setTimeout(() => {
        this.fetchTickets(1);
      }, 500);
    },
    
    async createTicket() {
      this.creatingTicket = true;
      try {
        const response = await fetch('/api/tickets', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(this.newTicket)
        });
        
        if (response.ok) {
          this.showModal = false;
          this.newTicket = { subject: '', body: '' };
          this.fetchTickets();
          this.$nextTick(() => {
            alert('Ticket created successfully! AI classification will start shortly.');
          });
        } else {
          const error = await response.json();
          alert('Error creating ticket: ' + JSON.stringify(error));
        }
      } catch (error) {
        console.error('Error creating ticket:', error);
        alert('Error creating ticket');
      }
      this.creatingTicket = false;
    },
    
    async classifyTicket(ticket) {
      this.classifyingTicket = ticket.id;
      try {
        const response = await fetch(`/api/tickets/${ticket.id}/classify`, {
          method: 'POST'
        });
        
        if (response.ok) {
          setTimeout(() => {
            this.fetchTickets(this.currentPage);
            this.classifyingTicket = null;
          }, 2000);
        } else {
          alert('Error classifying ticket');
          this.classifyingTicket = null;
        }
      } catch (error) {
        console.error('Error classifying ticket:', error);
        alert('Error classifying ticket');
        this.classifyingTicket = null;
      }
    },
    
    goToPage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.fetchTickets(page);
      }
    },
    
    truncateText(text, length) {
      if (!text) return '';
      return text.length > length ? text.substring(0, length) + '...' : text;
    },
    
    formatDate(dateString) {
      if (!dateString) return '';
      const date = new Date(dateString);
      return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
      });
    }
  }
}
</script>

<style scoped>
.ticket-list {
  padding: 20px;
  max-width: 1400px;
  margin: 0 auto;
}

.ticket-list__header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 2rem;
  padding: 2rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  color: white;
}

.header-content {
  flex: 1;
}

.header-title {
  font-size: 2.2rem;
  font-weight: 700;
  margin: 0 0 0.5rem 0;
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.header-title .icon {
  font-size: 2.5rem;
}

.header-subtitle {
  margin: 0;
  opacity: 0.9;
  font-size: 1.1rem;
}

.btn--with-icon {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  font-weight: 600;
}

/* Filters Section */
.filters-section {
  background: white;
  padding: 1.5rem;
  border-radius: 12px;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
  margin-bottom: 2rem;
}

.filters-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.filter-group {
  display: flex;
  flex-direction: column;
}

.filter-label {
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: #2d3748;
}

.filter-select {
  padding: 0.75rem;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.95rem;
  transition: border-color 0.2s ease;
}

.filter-select:focus {
  outline: none;
  border-color: #4299e1;
}

.search-input-wrapper {
  position: relative;
}

.search-icon {
  position: absolute;
  left: 0.75rem;
  top: 50%;
  transform: translateY(-50%);
  font-size: 1.1rem;
}

.search-input {
  padding: 0.75rem 0.75rem 0.75rem 2.5rem;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.95rem;
  width: 100%;
  transition: border-color 0.2s ease;
}

.search-input:focus {
  outline: none;
  border-color: #4299e1;
}

/* Tickets Grid */
.tickets-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.ticket-card {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
  border-left: 4px solid #e2e8f0;
  position: relative;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.ticket-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 25px rgba(0, 0, 0, 0.15);
}

.ticket-card--open {
  border-left-color: #e53e3e;
}

.ticket-card--pending {
  border-left-color: #ed8936;
}

.ticket-card--resolved {
  border-left-color: #38a169;
}

.ticket-card__header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.ticket-id {
  font-size: 0.85rem;
  color: #718096;
  font-weight: 500;
}

.status-badge {
  padding: 0.35rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
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

.ticket-card__content {
  margin-bottom: 1.5rem;
}

.ticket-subject {
  font-size: 1.1rem;
  font-weight: 600;
  color: #2d3748;
  margin: 0 0 0.75rem 0;
  line-height: 1.4;
}

.ticket-body {
  color: #718096;
  line-height: 1.5;
  margin: 0 0 1rem 0;
}

.ticket-meta {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.meta-label {
  font-weight: 600;
  font-size: 0.85rem;
  color: #4a5568;
}

.meta-value {
  font-size: 0.85rem;
  color: #718096;
}

.confidence-value {
  background: #ebf8ff;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  color: #2b6cb0;
  font-weight: 600;
}

.ticket-card__footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 1rem;
  border-top: 1px solid #e2e8f0;
}

.ticket-actions {
  display: flex;
  gap: 0.5rem;
}

.btn--small {
  padding: 0.5rem 0.75rem;
  font-size: 0.85rem;
}

.ticket-date {
  font-size: 0.8rem;
  color: #a0aec0;
}

.ticket-indicators {
  position: absolute;
  top: 1rem;
  right: 1rem;
  display: flex;
  gap: 0.5rem;
}

.indicator {
  font-size: 1.1rem;
  cursor: help;
}

/* Empty State */
.empty-state {
  text-align: center;
  padding: 4rem 2rem;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
}

.empty-state__icon {
  font-size: 4rem;
  margin-bottom: 1.5rem;
}

.empty-state__title {
  font-size: 1.5rem;
  color: #2d3748;
  margin: 0 0 1rem 0;
}

.empty-state__message {
  color: #718096;
  margin: 0 0 2rem 0;
  font-size: 1.1rem;
}

/* Pagination */
.pagination {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  align-items: center;
  margin-top: 2rem;
}

.pagination-info {
  color: #718096;
  font-size: 0.9rem;
}

.pagination-controls {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.pagination-btn {
  padding: 0.5rem 1rem;
  border: 1px solid #e2e8f0;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.pagination-btn:hover:not(:disabled) {
  background: #4299e1;
  color: white;
  border-color: #4299e1;
}

.pagination-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.pagination-pages {
  display: flex;
  gap: 0.5rem;
}

.pagination-page {
  padding: 0.5rem 0.75rem;
  border: 1px solid #e2e8f0;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.pagination-page:hover {
  background: #edf2f7;
}

.pagination-page--active {
  background: #4299e1;
  color: white;
  border-color: #4299e1;
}

/* Modal */
.modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  padding: 1rem;
}

.modal__content {
  background: white;
  border-radius: 16px;
  width: 100%;
  max-width: 500px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
}

.modal__header {
  padding: 1.5rem;
  border-bottom: 1px solid #e2e8f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal__header h2 {
  margin: 0;
  color: #2d3748;
}

.modal__close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: #718096;
}

form {
  padding: 1.5rem;
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

.form-input,
.form-textarea {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.2s ease;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: #4299e1;
}

.form-textarea {
  min-height: 120px;
  resize: vertical;
}

.modal__footer {
  padding: 1.5rem;
  border-top: 1px solid #e2e8f0;
  display: flex;
  justify-content: flex-end;
  gap: 1rem;
}

/* Responsive Design */
@media (max-width: 768px) {
  .ticket-list__header {
    flex-direction: column;
    gap: 1rem;
    text-align: center;
  }
  
  .header-title {
    justify-content: center;
  }
  
  .filters-grid {
    grid-template-columns: 1fr;
  }
  
  .tickets-grid {
    grid-template-columns: 1fr;
  }
  
  .ticket-card__footer {
    flex-direction: column;
    gap: 1rem;
    align-items: stretch;
  }
  
  .ticket-actions {
    justify-content: center;
  }
  
  .pagination-controls {
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .pagination-pages {
    order: -1;
  }
}

/* Loading Animation */
@keyframes spin {
  to { transform: rotate(360deg); }
}

.loading {
  display: inline-block;
  width: 16px;
  height: 16px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: white;
  animation: spin 1s ease-in-out infinite;
}

.btn:disabled .loading {
  border-top-color: currentColor;
}
</style>