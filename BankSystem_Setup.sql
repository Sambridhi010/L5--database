-- ======================================================
-- 1. DATABASE & TABLES SETUP
-- ======================================================
DROP DATABASE IF EXISTS BankDB;
CREATE DATABASE BankDB;
USE BankDB;

-- Create Accounts Table
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts(
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(10,2)
);

-- Create Employees Table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

-- Create Salary Log Table
DROP TABLE IF EXISTS salary_log;
CREATE TABLE salary_log(
    logId INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Initial Data
INSERT INTO accounts VALUES
(1, 'Ram', 50000),
(2, 'Shyam', 30000),
(3, 'Sita', 20000);

-- ======================================================
-- 2. TRIGGERS
-- ======================================================

-- Trigger to prevent low salary insertion
DROP TRIGGER IF EXISTS check_salary;
DELIMITER $$
CREATE TRIGGER check_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 10000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 10000';
    END IF;
END $$
DELIMITER ;

-- Trigger to log salary changes
DROP TRIGGER IF EXISTS log_salary_update;
DELIMITER $$
CREATE TRIGGER log_salary_update 
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_log(emp_id, old_salary, new_salary)
    VALUES(OLD.emp_id, OLD.salary, NEW.salary);
END $$
DELIMITER ;

-- ======================================================
-- 3. STORED PROCEDURES
-- ======================================================

-- Procedure: Get All Employees
DROP PROCEDURE IF EXISTS getEmployees;
DELIMITER $$
CREATE PROCEDURE getEmployees()
BEGIN
    SELECT * FROM employees;
END $$
DELIMITER ;

-- Procedure: Add New Employee
DROP PROCEDURE IF EXISTS addEmployee;
DELIMITER $$
CREATE PROCEDURE addEmployee(
    IN p_id INT, 
    IN p_name VARCHAR(100), 
    IN p_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO employees (emp_id, name, salary) 
    VALUES (p_id, p_name, p_salary);
END $$
DELIMITER ;

-- Procedure: Update Salary
DROP PROCEDURE IF EXISTS updateSalary;
DELIMITER $$
CREATE PROCEDURE updateSalary(
    IN p_id INT,
    IN p_new_salary DECIMAL(10,2)
)
BEGIN
    UPDATE employees 
    SET salary = p_new_salary
    WHERE emp_id = p_id;
END $$
DELIMITER ;

-- Procedure: Transfer Money between accounts
DROP PROCEDURE IF EXISTS transferMoney;
DELIMITER $$
CREATE PROCEDURE transferMoney(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    START TRANSACTION;
    UPDATE accounts SET balance = balance - amount WHERE account_id = from_account;
    UPDATE accounts SET balance = balance + amount WHERE account_id = to_account;
    COMMIT;
END $$
DELIMITER ;

-- ======================================================
-- 4. EXECUTION & TESTING
-- ======================================================

-- Part A: Transaction Testing (Savepoint & Rollback)
START TRANSACTION;
    UPDATE accounts SET balance = balance - 2000 WHERE account_id = 1;
    SAVEPOINT sp1;
    UPDATE accounts SET balance = balance + 2000 WHERE account_id = 2;
    ROLLBACK TO sp1; -- Reverts the addition to Shyam, keeps the deduction from Ram
COMMIT;

-- Part B: Testing Procedures & Triggers
CALL addEmployee(1, 'Hari', 25000);
CALL updateSalary(1, 30000);
CALL transferMoney(1, 2, 5000);

-- Final Results Verification
SELECT 'ACCOUNTS' as '';
SELECT * FROM accounts;

SELECT 'EMPLOYEES' as '';
SELECT * FROM employees;

SELECT 'SALARY LOG' as '';
SELECT * FROM salary_log;