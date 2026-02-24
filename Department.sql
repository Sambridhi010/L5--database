CREATE DATABASE IF NOT EXISTS department;
USE department;

CREATE TABLE DEPT (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(255),
    LOC VARCHAR(255)
);

RENAME TABLE DEPT TO department;

ALTER table department
add column PINCODE int not null default 0;

ALTER TABLE department
RENAME COLUMN DNAME TO DEPT_NAME;

ALTER TABLE department
MODIFY LOC Char(20);

Drop table department;
