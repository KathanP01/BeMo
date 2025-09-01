<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[WebReinvent](https://webreinvent.com/)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel/)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Jump24](https://jump24.co.uk)**
- **[Redberry](https://redberry.international/laravel/)**
- **[Active Logic](https://activelogic.com)**
- **[byte5](https://byte5.de)**
- **[OP.GG](https://op.gg)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).


---

# Project Explanation: Smart Ticket Triage

### Setup

- **Terminal 1** → `php artisan serve` → Laravel backend (API + routes)  
  Example:  C:\Kathan\xampp\htdocs\smart-ticket-triage>php artisan serve

- **Terminal 2** → `npm run dev` → Vite frontend (Vue app for UI)  
  Example:  C:\Kathan\xampp\htdocs\smart-ticket-triage>npm run dev

  
---

### 1. Dashboard Page  
**URL:** `http://127.0.0.1:8000/dashboard`

**Features:**
- Show statistics (total tickets, open tickets, resolved tickets, etc.).
- Show charts (maybe line charts or pie charts) using Chart.js.
- Optionally show real-time updates (tickets updating without refresh).

---

### 2. Tickets List Page  
**URL:** `http://127.0.0.1:8000/tickets`

**Features:**
- Show a list of tickets (like a table or cards).
- Filter by status → Open, Pending, Resolved.
- Filter by category → IT, HR, Billing, etc.
- Search bar → find tickets quickly by keywords.
- Create New Ticket → Button “+ New Ticket” opens a modal.

---

### 3. Ticket Detail Page  
**Accessed when you click a ticket from the list**

**Features:**
- View full details.  
- Update manually.  
- Re-classify with AI → Calls OpenAI API to suggest correct category.  

---

## How It Works (Behind the Scenes)

### 1. Laravel (Backend)
- Handles API requests (`/api/tickets`, `/api/dashboard`).  
- Connects to the database (MySQL) to store tickets.  
- Provides JSON data for Vue frontend.  

### 2. Vue.js + Vite (Frontend)
- Displays the UI (Dashboard, Tickets, Ticket Details).  
- Uses Vue Router → `/dashboard`, `/tickets`, `/tickets/:id`.  
- Uses Axios → calls backend APIs to get ticket data.  
- Uses Chart.js → draws graphs in Dashboard.  

### 3. OpenAI API
- When clicks “Re-classify with AI” → ticket text is sent to OpenAI.  
- AI returns a category → “IT”, “Billing”, “HR”.  
- Laravel saves updated category in the database.  


## Application Preview
![1](https://github.com/user-attachments/assets/217525b4-a282-4592-9306-1c6f71d5ee1a)
![2](https://github.com/user-attachments/assets/95c41147-252a-4082-bde9-d795b078f74f)
![3](https://github.com/user-attachments/assets/5efa0c10-5d6a-43de-9f04-6834e50906d9)
![4](https://github.com/user-attachments/assets/c1eb532a-1b8a-4a1e-bc3f-4f4633302d3e)
![5](https://github.com/user-attachments/assets/d37cdd38-d762-4751-8e43-4b1d4b27152a)
![6](https://github.com/user-attachments/assets/dc18371c-9398-4d78-8450-e89ac813cc10)






