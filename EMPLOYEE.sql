SHOW DATABASES;
USE employees;

-- 1️⃣ Create DEPARTMENT table FIRST
CREATE TABLE DEPARTMENT (
    DNO INT PRIMARY KEY,
    Dname VARCHAR(20),
    Mgrstartdate INT,
    MgrSSN INT
);

-- 2️⃣ Insert department data
INSERT INTO DEPARTMENT VALUES (1, 'HR', 2020, 101);
INSERT INTO DEPARTMENT VALUES (2, 'Finance', 2021, 102);
INSERT INTO DEPARTMENT VALUES (3, 'IT', 2019, 103);
INSERT INTO DEPARTMENT VALUES (4, 'Marketing', 2022, 104);

-- 3️⃣ Create employee2 table AFTER department
CREATE TABLE employee2 (
    Fname VARCHAR(20),
    LName VARCHAR(20),
    SSN INT PRIMARY KEY,
    Address VARCHAR(20),
    sex CHAR(1),
    salary INT,
    superSSN INT,
    DNO INT,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO)
);

-- 4️⃣ Insert employee data
INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES 
('Amit', 'Shrestha', 115, 'Chitwan', 'M', 48000, 113, 4);

-- 5️⃣ Query with corrected department name (Marketing instead of research)
SELECT E.Fname, E.LName,
E.salary * 1.10 AS increased_salary
FROM employee2 E
JOIN DEPARTMENT D 
ON E.DNO = D.DNO
WHERE D.Dname = 'Marketing';

-- 6️⃣ Aggregate query (Corrected department name)
SELECT SUM(E.salary) AS total_salary,
       MAX(E.salary) AS max_salary,
       MIN(E.salary) AS min_salary,
       AVG(E.salary) AS avg_salary
FROM employee2 E
JOIN DEPARTMENT D 
ON E.DNO = D.DNO
WHERE D.Dname = 'HR';

-- 7️⃣ Select employees by existing department
SELECT Fname, LName 
FROM employee2
WHERE DNO = 4;

#using exists
select FNAME, LNAME from EMPLOYEE E
where exists(select 1 from EMPLOYEE e
where e.DNO=5 and E.SSN= e.SSN);

SELECT D.DNO, D.DNAME, COUNT(E.SSN) AS Total_Employees
FROM DEPARTMENT D
JOIN employee2 E ON D.DNO = E.DNO
GROUP BY D.DNO, D.DNAME
HAVING COUNT(E.SSN) >= 2;

#qn.5

SELECT * from  EMPLOYEE
 where year(BDATE) between 1990 and 1999;
 
 #q.6
 select E.NAME, L.NAME, D.NAME
 FROM EMPLOYEE employee
 JOIN DEPARTMENT D
 ON E.NO=D.NUMBER;
 


