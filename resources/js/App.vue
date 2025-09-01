<template>
  <div id="app">
    <nav class="navbar">
    <div class="navbar__brand">
        <router-link to="/dashboard" class="navbar__logo-link">
          <img 
            src="https://cdn-icons-png.flaticon.com/512/2621/2621081.png" 
            alt="Smart Ticket Logo" 
            class="navbar__logo" 
          />
          <span>Smart Ticket Triage</span>
        </router-link>
      </div>

      <button class="navbar__toggle" @click="isOpen = !isOpen">
        ☰
      </button>

      <div :class="['navbar__menu', { 'navbar__menu--open': isOpen }]">
        <router-link to="/tickets" class="navbar__link">🎫 Tickets</router-link>
        <router-link to="/dashboard" class="navbar__link">📊 Dashboard</router-link>
      </div>
    </nav>

    <main class="main-content">
      <router-view></router-view>
    </main>
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {
      isOpen: false,
    }
  },
}
</script>

<style>

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: #f5f5f5;
  color: #333;
}

.navbar {
  background: linear-gradient(135deg, #2c3e50, #34495e);
  color: white;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 3px 6px rgba(0,0,0,0.15);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.navbar__brand {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  font-size: 1.4rem;
  font-weight: bold;
}

.navbar__logo-link {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: white;
  text-decoration: none;
  font-size: 1.5rem;
  font-weight: bold;
}

.navbar__logo {
  width: 40px;
  height: 40px;
}


.navbar__menu {
  display: flex;
  gap: 1rem;
}

.navbar__link {
  color: white;
  text-decoration: none;
  padding: 0.6rem 1rem;
  border-radius: 6px;
  transition: all 0.3s ease;
  font-weight: 500;
}
.navbar__link:hover {
  background: rgba(255, 255, 255, 0.15);
}
.navbar__link.router-link-active {
  background: #3498db;
  color: #fff;
  font-weight: bold;
}

.navbar__toggle {
  display: none;
  background: none;
  border: none;
  color: white;
  font-size: 1.5rem;
  cursor: pointer;
}
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.4rem;
  padding: 0.7rem 1.4rem;
  font-size: 0.95rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
  border: none;
}

.btn--primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}
.btn--primary:hover:not(:disabled) {
  background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
  transform: translateY(-1px);
}

.btn--secondary {
  background: #edf2f7;
  color: #2d3748;
  border: 1px solid #cbd5e0;
}
.btn--secondary:hover:not(:disabled) {
  background: #e2e8f0;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn--small {
  padding: 0.4rem 0.9rem;
  font-size: 0.85rem;
}
@media (max-width: 768px) {
  .navbar__toggle {
    display: block;
  }
  .navbar__menu {
    display: none;
    flex-direction: column;
    background: #2c3e50;
    position: absolute;
    top: 70px;
    right: 20px;
    padding: 1rem;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
  }
  .navbar__menu--open {
    display: flex;
  }
}


.main-content {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}
</style>
