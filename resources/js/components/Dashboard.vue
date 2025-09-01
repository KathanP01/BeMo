<template>
  <div class="dashboard">
    <h1>Analytics Dashboard</h1>
    
    <div v-if="loading" class="loading-state">Loading dashboard data...</div>
    
    <div v-else class="dashboard__content">
      <div class="dashboard__stats">
        <div class="stat-card">
          <div class="stat-card__value">{{ stats.total || 0 }}</div>
          <div class="stat-card__label">Total Tickets</div>
        </div>
        
        <div class="stat-card">
          <div class="stat-card__value">{{ stats.status?.open || 0 }}</div>
          <div class="stat-card__label">Open Tickets</div>
        </div>
        
        <div class="stat-card">
          <div class="stat-card__value">{{ stats.status?.pending || 0 }}</div>
          <div class="stat-card__label">Pending Tickets</div>
        </div>
        
        <div class="stat-card">
          <div class="stat-card__value">{{ stats.status?.resolved || 0 }}</div>
          <div class="stat-card__label">Resolved Tickets</div>
        </div>
      </div>

      <div class="dashboard__charts">
        <div class="chart-card">
          <h2>Tickets by Category</h2>
          <div class="chart-container">
            <canvas ref="categoryChart" class="chart-canvas"></canvas>
          </div>
          <div v-if="!hasCategoryData" class="no-data">
            No category data available
          </div>
        </div>
        
        <div class="chart-card">
          <h2>Tickets by Status</h2>
          <div class="chart-container">
            <canvas ref="statusChart" class="chart-canvas"></canvas>
          </div>
          <div v-if="!hasStatusData" class="no-data">
            No status data available
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

export default {
  name: 'Dashboard',
  data() {
    return {
      stats: {
        status: {},
        categories: {},
        total: 0
      },
      loading: true,
      categoryChart: null,
      statusChart: null
    }
  },
  computed: {
    hasCategoryData() {
      return this.stats.categories && Object.keys(this.stats.categories).length > 0;
    },
    hasStatusData() {
      return this.stats.status && Object.keys(this.stats.status).length > 0;
    }
  },
  async mounted() {
    await this.fetchStats();
  },
  beforeUnmount() {
    this.destroyCharts();
  },
  methods: {
    async fetchStats() {
      this.loading = true;
      try {
        const response = await fetch('/api/stats');
        if (response.ok) {
          this.stats = await response.json();
          // Wait a bit for the DOM to be fully ready
          setTimeout(() => {
            this.renderCharts();
          }, 300);
        } else {
          console.error('Error fetching stats:', response.status);
        }
      } catch (error) {
        console.error('Error fetching stats:', error);
      }
      this.loading = false;
    },
    
    renderCharts() {
      this.destroyCharts();
      
      if (this.hasCategoryData) {
        this.renderCategoryChart();
      }
      
      if (this.hasStatusData) {
        this.renderStatusChart();
      }
    },
    
    renderCategoryChart() {
      const ctx = this.$refs.categoryChart;
      if (!ctx) return;
      
      this.categoryChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
          labels: Object.keys(this.stats.categories),
          datasets: [{
            data: Object.values(this.stats.categories),
            backgroundColor: [
              '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0',
              '#9966FF', '#FF9F40', '#8ac6d1', '#ff6b6b'
            ],
            borderWidth: 2,
            borderColor: '#fff'
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'bottom',
              labels: {
                padding: 15,
                font: {
                  size: 12
                }
              }
            }
          },
          animation: {
            animateScale: true
          }
        }
      });
    },
    
    renderStatusChart() {
      const ctx = this.$refs.statusChart;
      if (!ctx) return;
      
      this.statusChart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: Object.keys(this.stats.status),
          datasets: [{
            label: 'Number of Tickets',
            data: Object.values(this.stats.status),
            backgroundColor: [
              '#e74c3c', '#f39c12', '#2ecc71'
            ],
            borderWidth: 0,
            borderRadius: 4
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                stepSize: 1
              },
              grid: {
                color: 'rgba(0, 0, 0, 0.1)'
              }
            },
            x: {
              grid: {
                display: false
              }
            }
          },
          plugins: {
            legend: {
              display: false
            }
          }
        }
      });
    },
    
    destroyCharts() {
      if (this.categoryChart) {
        this.categoryChart.destroy();
        this.categoryChart = null;
      }
      if (this.statusChart) {
        this.statusChart.destroy();
        this.statusChart = null;
      }
    }
  }
}
</script>

<style scoped>
.dashboard {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.dashboard h1 {
  color: #2c3e50;
  margin-bottom: 30px;
  text-align: center;
}

.dashboard__stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.stat-card {
  background: white;
  border-radius: 12px;
  padding: 25px;
  text-align: center;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  border: 1px solid #e8e8e8;
  transition: transform 0.2s ease;
}

.stat-card:hover {
  transform: translateY(-2px);
}

.stat-card__value {
  font-size: 2.5rem;
  font-weight: bold;
  color: #3498db;
  margin-bottom: 8px;
}

.stat-card__label {
  color: #7f8c8d;
  font-size: 0.9rem;
  text-transform: uppercase;
  font-weight: 600;
  letter-spacing: 0.5px;
}

.dashboard__charts {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
  gap: 25px;
}

.chart-card {
  background: white;
  border-radius: 12px;
  padding: 25px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  border: 1px solid #e8e8e8;
}

.chart-card h2 {
  margin: 0 0 20px 0;
  color: #2c3e50;
  font-size: 1.4rem;
  text-align: center;
}

.chart-container {
  position: relative;
  height: 350px;
  width: 100%;
  min-height: 350px;
}

.chart-canvas {
  display: block;
  width: 100% !important;
  height: 100% !important;
}

.loading-state {
  text-align: center;
  padding: 40px;
  font-style: italic;
  color: #7f8c8d;
  background: white;
  border-radius: 12px;
  margin: 20px 0;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.no-data {
  text-align: center;
  padding: 40px 20px;
  color: #95a5a6;
  font-style: italic;
  background: #f8f9fa;
  border-radius: 8px;
  margin: 10px 0;
}

@media (max-width: 768px) {
  .dashboard__charts {
    grid-template-columns: 1fr;
  }
  
  .chart-container {
    height: 300px;
  }
  
  .stat-card {
    padding: 20px;
  }
  
  .stat-card__value {
    font-size: 2rem;
  }
}
</style>