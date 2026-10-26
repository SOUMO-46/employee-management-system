# Employee Management System

A professional web-based **Employee Management System** built with **PHP OOP, MySQL, REST API, HTML, CSS and JavaScript**.

The system provides a structured solution for managing employees, attendance, leave requests and salary information through a clean and organized web interface.

---

## 🚀 Features

### 👨‍💼 Employee Management

- Add new employees
- View employee records
- Update employee information
- Delete employees
- Employee details management
- Employee listing interface

### 🕒 Attendance Management

- Employee attendance tracking
- Attendance records
- Attendance management interface
- Attendance-related backend functionality

### 📝 Leave Management

- Manage employee leave requests
- View leave information
- Leave request handling
- Leave management interface

### 💰 Salary Management

- Employee salary management
- Salary information
- Salary management interface

### 🔌 REST API

The project includes a REST API for backend communication.

API functionality is handled through:

```text
api/index.php
```

The API can be tested using tools such as **Postman**.

### 📚 API Documentation

The project includes an API documentation page:

```text
public/api-docs.php
```

---

## 🛠️ Technologies Used

### Frontend

- HTML5
- CSS3
- JavaScript
- Fetch API

### Backend

- PHP
- PHP OOP
- REST API
- Object-Oriented Architecture

### Database

- MySQL
- MySQLi / Database abstraction
- SQL

### Development Tools

- XAMPP
- phpMyAdmin
- Postman
- Git
- GitHub
- VS Code

---

## 📁 Project Structure

```text
employee-management-system/
│
├── api/
│   └── index.php
│
├── classes/
│   ├── Attendance.php
│   ├── Employee.php
│   ├── LeaveRequest.php
│   └── Salary.php
│
├── config/
│   ├── bootstrap.php
│   ├── config.php
│   └── Database.php
│
├── database/
│   └── database.sql
│
├── partials/
│   ├── footer.php
│   └── header.php
│
├── public/
│   ├── assets/
│   │   ├── css/
│   │   │   └── app.css
│   │   └── js/
│   │       └── app.js
│   │
│   ├── api-docs.php
│   ├── attendance.php
│   ├── employee-delete.php
│   ├── employee-form.php
│   ├── employees.php
│   ├── index.php
│   ├── leave.php
│   └── salary.php
│
└── README.md
```

---

## 🔄 Application Architecture

The application follows a structured PHP OOP architecture.

```text
User
 │
 ▼
Frontend / PHP Pages
 │
 ▼
API Layer
 │
 ▼
Classes
 │
 ├── Employee
 ├── Attendance
 ├── LeaveRequest
 └── Salary
 │
 ▼
Database
 │
 ▼
MySQL
```

---

## 💻 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/employee-management-system.git
```

Move into the project directory:

```bash
cd employee-management-system
```

---

### 2. Install XAMPP

Install **XAMPP** and start:

- Apache
- MySQL

Place the project inside:

```text
C:\xampp\htdocs\
```

For example:

```text
C:\xampp\htdocs\employee-management-system
```

---

### 3. Create the Database

Open phpMyAdmin:

```text
http://localhost/phpmyadmin
```

Create the required database according to the project configuration.

Check:

```text
config/config.php
```

and:

```text
config/Database.php
```

for the database configuration.

---

### 4. Import Database

In phpMyAdmin, select your database and import:

```text
database/database.sql
```

This SQL file contains the required database structure and data.

---

### 5. Configure Database

Open:

```text
config/Database.php
```

Configure the local MySQL connection according to your XAMPP environment.

Typical local configuration:

```php
$host = "localhost";
$username = "root";
$password = "";
$database = "your_database_name";
```

Use the database name configured for your project.

---

## 🌐 Run the Project

After starting Apache and MySQL, open:

```text
http://localhost/employee-management-system/public/
```

The main dashboard should load from the `public` directory.

---

## 👨‍💼 Main Modules

| Module | Description |
|---|---|
| Dashboard | Main system overview |
| Employees | Employee CRUD management |
| Attendance | Employee attendance management |
| Leave | Employee leave management |
| Salary | Employee salary management |
| REST API | API-based backend communication |
| API Docs | API endpoint documentation |

---

## 🔌 REST API

The REST API entry point is:

```text
api/index.php
```

API documentation is available at:

```text
public/api-docs.php
```

You can use **Postman** to test API requests.

Typical REST operations include:

```text
GET
POST
PUT
DELETE
```

The exact available endpoints can be checked from the API documentation included with the project.

---

## 🗄️ Database

The project database structure is stored in:

```text
database/database.sql
```

The database is responsible for storing information related to:

- Employees
- Attendance
- Leave
- Salary
- Other application records

---

## 🎨 Frontend

The project includes custom CSS and JavaScript:

```text
public/assets/css/app.css
public/assets/js/app.js
```

The frontend provides the user interface and client-side functionality for the management system.

---

## 🔐 Security

The project is organized using separate configuration, class and API layers to make the application easier to maintain and extend.

For production deployment, additional security features are recommended, including:

- Authentication
- Authorization
- Role-based access control
- CSRF protection
- Input sanitization
- API authentication
- Rate limiting
- Secure environment variables
- HTTPS

---

## 🧪 Testing

### Web Application

Open:

```text
http://localhost/employee-management-system/public/
```

### API

Use:

```text
api/index.php
```

with Postman.

### API Documentation

Open:

```text
http://localhost/employee-management-system/public/api-docs.php
```

---

## 🎯 Project Purpose

This project was developed as a practical full-stack PHP project to demonstrate:

- PHP Object-Oriented Programming
- MySQL database management
- CRUD operations
- REST API development
- Employee management
- Attendance management
- Leave management
- Salary management
- Frontend and backend integration
- Structured project architecture
- Git and GitHub workflow

---

## 🔮 Future Improvements

The following features can be added in future versions:

- Admin authentication
- Employee login
- Role-based permissions
- Employee profile management
- RFID attendance
- Advanced attendance reports
- Monthly salary calculation
- Payslip generation
- PDF reports
- Excel export
- Dashboard charts
- Advanced search and filtering
- Pagination
- Email notifications
- API authentication
- Activity logs

---

## 👨‍💻 Author

**Soumo**

Full-Stack Web Developer

### Skills

```text
HTML
CSS
JavaScript
PHP
PHP OOP
MySQL
REST API
Git
GitHub
```

---

## 📄 License

This project was developed for learning, portfolio and development purposes.
