-- Tạo Database
CREATE DATABASE IF NOT EXISTS hr;

-- Sử dụng Database
USE hr;

-- Tạo bảng Employees
DROP TABLE IF EXISTS EMPLOYEES;
CREATE TABLE EMPLOYEES (
    EMP_ID INT AUTO_INCREMENT PRIMARY KEY,
    F_NAME VARCHAR(50),
    L_NAME VARCHAR(50),
    SSN VARCHAR(11),
    B_DATE DATE,
    SEX CHAR(1),
    ADDRESS VARCHAR(255),
    JOB_ID INT,
    SALARY DECIMAL(10,2),
    MANAGER_ID INT,
    DEP_ID INT,
    FOREIGN KEY (JOB_ID) REFERENCES Jobs(JOB_IDENT),
    FOREIGN KEY (MANAGER_ID) REFERENCES Employees(EMP_ID),
    FOREIGN KEY (DEP_ID) REFERENCES Departments(DEPT_ID)
);

-- Tạo bảng Job_History
CREATE TABLE IF NOT EXISTS Job_History (
    EMPL_ID INT,
    START_DATE DATE,
    JOB_ID INT,
    DEPT_ID INT,
    FOREIGN KEY (EMPL_ID) REFERENCES Employees(EMP_ID),
    FOREIGN KEY (JOB_ID) REFERENCES Jobs(JOB_IDENT),
    FOREIGN KEY (DEPT_ID) REFERENCES Departments(DEPT_ID)
);

-- Tạo bảng Jobs
CREATE TABLE IF NOT EXISTS Jobs (
    JOB_IDENT INT AUTO_INCREMENT PRIMARY KEY,
    JOB_TITLE VARCHAR(50),
    MIN_SALARY DECIMAL(10,2),
    MAX_SALARY DECIMAL(10,2)
);

-- Tạo bảng Departments
CREATE TABLE IF NOT EXISTS Departments (
    DEPT_ID INT AUTO_INCREMENT PRIMARY KEY,
    DEP_NAME VARCHAR(50),
    MANAGER_ID INT,
    LOC_ID INT,
    FOREIGN KEY (MANAGER_ID) REFERENCES Employees(EMP_ID),
    FOREIGN KEY (LOC_ID) REFERENCES Locations(LOC_ID)
);

-- Tạo bảng Locations
CREATE TABLE IF NOT EXISTS Locations (
    LOC_ID INT AUTO_INCREMENT PRIMARY KEY,
    DEP_ID_LOC INT,
    FOREIGN KEY (DEP_ID_LOC) REFERENCES Departments(DEPT_ID)
);
