CREATE DATABASE IF NOT EXISTS employee_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE employee_management;

CREATE TABLE IF NOT EXISTS employees (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 employee_code VARCHAR(30) NOT NULL UNIQUE,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE,
 phone VARCHAR(20) NOT NULL,
 department VARCHAR(100) NOT NULL,
 designation VARCHAR(100) NOT NULL,
 joining_date DATE NOT NULL,
 basic_salary DECIMAL(12,2) NOT NULL DEFAULT 0,
 status ENUM('active','inactive') NOT NULL DEFAULT 'active',
 address VARCHAR(255) DEFAULT NULL,
 city VARCHAR(100) DEFAULT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 INDEX idx_department(department), INDEX idx_status(status), INDEX idx_joining_date(joining_date)
);
CREATE TABLE IF NOT EXISTS attendance (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 employee_id INT UNSIGNED NOT NULL,
 attendance_date DATE NOT NULL,
 status ENUM('present','absent','late','half_day','leave') NOT NULL,
 entry_time TIME NULL,
 exit_time TIME NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_employee_date(employee_id,attendance_date),
 INDEX idx_attendance_date(attendance_date),
 FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS leave_requests (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 employee_id INT UNSIGNED NOT NULL,
 leave_type ENUM('casual','sick','earned','unpaid','other') NOT NULL,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 reason VARCHAR(500) NOT NULL,
 status ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_leave_employee(employee_id), INDEX idx_leave_dates(start_date,end_date), INDEX idx_leave_status(status),
 FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS salaries (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 employee_id INT UNSIGNED NOT NULL,
 salary_month CHAR(7) NOT NULL,
 basic_salary DECIMAL(12,2) NOT NULL,
 allowance DECIMAL(12,2) NOT NULL DEFAULT 0,
 overtime DECIMAL(12,2) NOT NULL DEFAULT 0,
 deduction DECIMAL(12,2) NOT NULL DEFAULT 0,
 net_salary DECIMAL(12,2) NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_salary(employee_id,salary_month),
 INDEX idx_salary_month(salary_month),
 FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Demo data: safe to run on a fresh database. Existing demo codes are ignored.
INSERT IGNORE INTO employees (employee_code,name,email,phone,department,designation,joining_date,basic_salary,status,address,city) VALUES
('EMP-1001','Arjun Sen','arjun.sen@example.com','9876543201','Engineering','Senior PHP Developer','2023-04-10',65000,'active','Salt Lake Sector V','Kolkata'),
('EMP-1002','Maya Roy','maya.roy@example.com','9876543202','Human Resources','HR Executive','2024-01-15',48000,'active','New Town','Kolkata'),
('EMP-1003','Rohan Das','rohan.das@example.com','9876543203','Finance','Accountant','2022-09-01',52000,'active','B.T. Road','Kolkata'),
('EMP-1004','Priya Ghosh','priya.ghosh@example.com','9876543204','Operations','Operations Manager','2021-07-19',72000,'active','Shyambazar','Kolkata'),
('EMP-1005','Sourav Paul','sourav.paul@example.com','9876543205','Support','Support Specialist','2025-02-03',39000,'active','Barrackpore','North 24 Parganas'),
('EMP-1006','Nisha Kapoor','nisha.kapoor@example.com','9876543206','Marketing','Marketing Executive','2023-11-06',45000,'inactive','Rajarhat','Kolkata'),
('EMP-1008','Vikram Singh','vikram.singh@example.com','9876543207','Sales','Sales Representative','2022-06-21',52000,'active','B.T. Road','Kolkata'),
('EMP-1009','Ananya Chatterjee','ananya.chatterjee@example.com','9876543208','IT','IT Specialist','2024-03-10',60000,'active','Salt Lake Sector V','Kolkata'),
('EMP-1010','Kabir Mehta','kabir.mehta@example.com','9876543209','Customer Support','Customer Support Specialist','2023-09-15',46000,'active','New Town','Kolkata'),
('EMP-1011','Ishita Sen','ishita.sen@example.com','9876543210','Quality Assurance','QA Engineer','2022-12-01',55000,'active','B.T. Road','Kolkata'),
('EMP-1012','Raghav Sharma','raghav.sharma@example.com','9876543211','Product Management','Product Manager','2025-04-19',68000,'active','Shyambazar','Kolkata'),
('EMP-1013','Anika Roy','anika.roy@example.com','9876543212','Design','UI/UX Designer','2023-08-03',49000,'active','Barrackpore','North 24 Parganas'),
('EMP-1014','Devansh Kapoor','devansh.kapoor@example.com','9876543213','HR','HR Manager','2022-10-06',53000,'active','Rajarhat','Kolkata'),
('EMP-1015','Saanvi Mehta','saanvi.mehta@example.com','9876543214','Sales','Sales Representative','2024-05-21',56000,'active','B.T. Road','Kolkata');


INSERT INTO attendance(employee_id,attendance_date,status,entry_time,exit_time)
SELECT id,CURDATE(),'present','09:02:00','18:08:00' FROM employees WHERE employee_code='EMP-1001'
ON DUPLICATE KEY UPDATE status=VALUES(status),entry_time=VALUES(entry_time),exit_time=VALUES(exit_time);
INSERT INTO attendance(employee_id,attendance_date,status,entry_time,exit_time)
SELECT id,CURDATE(),'late','09:37:00','18:12:00' FROM employees WHERE employee_code='EMP-1002'
ON DUPLICATE KEY UPDATE status=VALUES(status),entry_time=VALUES(entry_time),exit_time=VALUES(exit_time);
INSERT INTO attendance(employee_id,attendance_date,status,entry_time,exit_time)
SELECT id,CURDATE(),'present','08:55:00','17:58:00' FROM employees WHERE employee_code='EMP-1003'
ON DUPLICATE KEY UPDATE status=VALUES(status),entry_time=VALUES(entry_time),exit_time=VALUES(exit_time);
INSERT INTO attendance(employee_id,attendance_date,status,entry_time,exit_time)
SELECT id,CURDATE(),'half_day','09:10:00','13:30:00' FROM employees WHERE employee_code='EMP-1004'
ON DUPLICATE KEY UPDATE status=VALUES(status),entry_time=VALUES(entry_time),exit_time=VALUES(exit_time);

INSERT INTO leave_requests(employee_id,leave_type,start_date,end_date,reason,status)
SELECT id,'casual',DATE_ADD(CURDATE(),INTERVAL 3 DAY),DATE_ADD(CURDATE(),INTERVAL 4 DAY),'Personal work','pending' FROM employees WHERE employee_code='EMP-1002';
INSERT INTO leave_requests(employee_id,leave_type,start_date,end_date,reason,status)
SELECT id,'sick',DATE_SUB(CURDATE(),INTERVAL 2 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY),'Medical rest','approved' FROM employees WHERE employee_code='EMP-1005';

INSERT INTO salaries(employee_id,salary_month,basic_salary,allowance,overtime,deduction,net_salary)
SELECT id,DATE_FORMAT(CURDATE(),'%Y-%m'),basic_salary,5000,2500,1200,basic_salary+5000+2500-1200 FROM employees WHERE employee_code='EMP-1001'
ON DUPLICATE KEY UPDATE basic_salary=VALUES(basic_salary),allowance=VALUES(allowance),overtime=VALUES(overtime),deduction=VALUES(deduction),net_salary=VALUES(net_salary);
INSERT INTO salaries(employee_id,salary_month,basic_salary,allowance,overtime,deduction,net_salary)
SELECT id,DATE_FORMAT(CURDATE(),'%Y-%m'),basic_salary,3500,1000,700,basic_salary+3500+1000-700 FROM employees WHERE employee_code='EMP-1002'
ON DUPLICATE KEY UPDATE basic_salary=VALUES(basic_salary),allowance=VALUES(allowance),overtime=VALUES(overtime),deduction=VALUES(deduction),net_salary=VALUES(net_salary);
