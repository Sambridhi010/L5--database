-- 1️⃣ Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DNO NUMBER PRIMARY KEY,
    Dname VARCHAR2(20),
    Mgrstartdate NUMBER,
    MgrSSN NUMBER
);

-- 2️⃣ Insert department data
INSERT INTO DEPARTMENT VALUES (1, 'HR', 2020, 101);
INSERT INTO DEPARTMENT VALUES (2, 'Finance', 2021, 102);
INSERT INTO DEPARTMENT VALUES (3, 'IT', 2019, 103);
INSERT INTO DEPARTMENT VALUES (4, 'Marketing', 2022, 104);

-- 3️⃣ Create EMPLOYEE2 table
CREATE TABLE EMPLOYEE2 (
    Fname VARCHAR2(20),
    LName VARCHAR2(20),
    SSN NUMBER PRIMARY KEY,
    Address VARCHAR2(20),
    Sex CHAR(1),
    Salary NUMBER,
    SuperSSN NUMBER,
    DNO NUMBER,
    CONSTRAINT FK_DEPT
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO)
);

-- 4️⃣ Insert employee data
INSERT INTO EMPLOYEE2
(Fname, LName, SSN, Address, Sex, Salary, SuperSSN, DNO)
VALUES
('Amit', 'Shrestha', 115, 'Chitwan', 'M', 48000, 113, 4);

-- 5️⃣ Salary increase query
SELECT E.Fname, E.LName,
       E.Salary * 1.10 AS Increased_Salary
FROM EMPLOYEE2 E
JOIN DEPARTMENT D
ON E.DNO = D.DNO
WHERE D.Dname = 'Marketing';

-- 6️⃣ Aggregate query
SELECT SUM(E.Salary) AS Total_Salary,
       MAX(E.Salary) AS Max_Salary,
       MIN(E.Salary) AS Min_Salary,
       AVG(E.Salary) AS Avg_Salary
FROM EMPLOYEE2 E
JOIN DEPARTMENT D
ON E.DNO = D.DNO
WHERE D.Dname = 'HR';

-- 7️⃣ Employees in department 4
SELECT Fname, LName
FROM EMPLOYEE2
WHERE DNO = 4;

-- Using EXISTS
SELECT Fname, LName
FROM EMPLOYEE2 E
WHERE EXISTS (
    SELECT 1
    FROM EMPLOYEE2 E2
    WHERE E2.DNO = 5
    AND E.SSN = E2.SSN
);

-- Departments having at least 2 employees
SELECT D.DNO, D.DNAME, COUNT(E.SSN) AS Total_Employees
FROM DEPARTMENT D
JOIN EMPLOYEE2 E
ON D.DNO = E.DNO
GROUP BY D.DNO, D.DNAME
HAVING COUNT(E.SSN) >= 2;

-- Q5: Employees born between 1990 and 1999
SELECT *
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM BDATE) BETWEEN 1990 AND 1999;

-- Q6: Example join
SELECT E.FNAME, E.LNAME, D.DNAME
FROM EMPLOYEE2 E
JOIN DEPARTMENT D
ON E.DNO = D.DNO;