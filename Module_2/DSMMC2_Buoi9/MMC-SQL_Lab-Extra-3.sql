-- Điều hướng đến cơ sở dữ liệu hr
USE hr;

-- Truy vấn 1: Truy xuất tất cả nhân viên có địa chỉ ở Elgin, IL
SELECT * FROM Employees WHERE ADDRESS LIKE '%Elgin, IL%';

-- Truy vấn 2: Truy xuất tất cả nhân viên sinh vào những năm 1970
SELECT * FROM Employees WHERE YEAR(B_DATE) = 1970;

-- Truy vấn 3: Truy xuất tất cả nhân viên trong phòng ban 5 có mức lương từ 60000 đến 70000
SELECT * FROM Employees WHERE DEP_ID = 5 AND SALARY BETWEEN 60000 AND 70000;

-- Truy vấn 4A: Truy xuất danh sách nhân viên được sắp xếp theo ID phòng ban
SELECT * FROM Employees ORDER BY DEP_ID;

-- Truy vấn 4B: Truy xuất danh sách nhân viên được sắp xếp theo thứ tự giảm dần theo ID phòng ban và trong mỗi phòng ban, những nhân viên này được sắp xếp theo họ với thứ tự giảm dần của bảng chữ cái
SELECT * FROM Employees ORDER BY DEP_ID DESC, L_NAME DESC;

-- Truy vấn 5A: Đối với mỗi ID phòng ban, truy xuất số lượng nhân viên trong phòng ban
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES FROM Employees GROUP BY DEP_ID;

-- Truy vấn 5B: Đối với mỗi phòng ban, truy xuất số lượng nhân viên trong phòng ban và mức lương trung bình của nhân viên trong phòng ban
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM Employees GROUP BY DEP_ID;

-- Truy vấn 5C: Gắn nhãn các cột đã tính trong tập hợp kết quả của Truy vấn 5B là NUM_EMPLOYEES và AVG_SALARY
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM Employees GROUP BY DEP_ID;

-- Truy vấn 5D: Trong Truy vấn 5C, hãy sắp xếp tập hợp kết quả Mức lương trung bình
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM Employees GROUP BY DEP_ID ORDER BY AVG_SALARY;

-- Truy vấn 5E: Trong Truy vấn 5D, giới hạn kết quả thành ít hơn 4 nhân viên cho các phòng ban
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM Employees GROUP BY DEP_ID HAVING COUNT(*) < 4;
