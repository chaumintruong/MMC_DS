-- Bài toán 1
-- Lấy tên và ngày bắt đầu công việc của tất cả nhân viên làm việc trong phòng ban số 5
SELECT EMPLOYEES.F_NAME, EMPLOYEES.L_NAME, Job_History.START_DATE
FROM EMPLOYEES
JOIN Job_History ON EMPLOYEES.EMP_ID = Job_History.EMPL_ID
WHERE Job_History.DEPT_ID = 5;

-- Bài toán 2
-- Lấy tên, ngày bắt đầu công việc và tên công việc của tất cả nhân viên làm việc trong phòng ban số 5
SELECT EMPLOYEES.F_NAME, EMPLOYEES.L_NAME, Job_History.START_DATE, Jobs.JOB_TITLE
FROM EMPLOYEES
JOIN Job_History ON EMPLOYEES.EMP_ID = Job_History.EMPL_ID
JOIN Jobs ON Job_History.JOB_ID = Jobs.JOB_IDENT
WHERE Job_History.DEPT_ID = 5;

-- Bài toán 3
-- Left Outer Join trên các bảng EMPLOYEES và DEPARTMENT để lấy thông tin nhân viên và phòng ban
SELECT EMPLOYEES.EMP_ID, EMPLOYEES.L_NAME, Departments.DEPT_ID, Departments.DEP_NAME
FROM EMPLOYEES
LEFT JOIN Departments ON EMPLOYEES.DEP_ID = Departments.DEPT_ID;

-- Bài toán 4
-- Lấy thông tin nhân viên và phòng ban, chỉ cho những nhân viên sinh trước năm 1980
SELECT EMPLOYEES.EMP_ID, EMPLOYEES.L_NAME, Departments.DEPT_ID, Departments.DEP_NAME
FROM EMPLOYEES
LEFT JOIN Departments ON EMPLOYEES.DEP_ID = Departments.DEPT_ID
WHERE YEAR(EMPLOYEES.B_DATE) < 1980;

-- Bài toán 5
-- Sử dụng INNER JOIN thay vì LEFT OUTER JOIN để lấy thông tin nhân viên và phòng ban
SELECT EMPLOYEES.EMP_ID, EMPLOYEES.L_NAME, Departments.DEPT_ID, Departments.DEP_NAME
FROM EMPLOYEES
INNER JOIN Departments ON EMPLOYEES.DEP_ID = Departments.DEPT_ID;

-- Bài toán 6
-- FULL OUTER JOIN trên bảng EMPLOYEES và DEPARTMENT để lấy thông tin nhân viên và phòng ban
SELECT EMPLOYEES.F_NAME, EMPLOYEES.L_NAME, Departments.DEP_NAME
FROM EMPLOYEES
LEFT JOIN Departments ON EMPLOYEES.DEP_ID = Departments.DEPT_ID
UNION
SELECT EMPLOYEES.F_NAME, EMPLOYEES.L_NAME, Departments.DEP_NAME
FROM EMPLOYEES
RIGHT JOIN Departments ON EMPLOYEES.DEP_ID = Departments.DEPT_ID;

-- Bài toán 7
-- Lấy thông tin tất cả employee names và department names cho những nhân viên nam
SELECT EMPLOYEES.F_NAME, EMPLOYEES.L_NAME, Departments.DEPT_ID, Departments.DEP_NAME
FROM EMPLOYEES
JOIN Departments ON EMPLOYEES.DEP_ID = Departments.DEPT_ID
WHERE EMPLOYEES.SEX = 'M';