USE Testing_System_Db;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban "sale"
CREATE VIEW SaleEmployees AS
SELECT A.*
FROM Account A
JOIN Department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale';

SELECT * 
FROM SaleEmployees;

-- Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE VIEW MostGroupMembers AS
SELECT A.*, NumGroups
FROM Account A
JOIN (
    SELECT AccountID, COUNT(*) AS NumGroups
    FROM GroupAccount
    GROUP BY AccountID
    ORDER BY NumGroups DESC
    LIMIT 1
) AS GroupCounts ON A.AccountID = GroupCounts.AccountID;

SELECT *
FROM MostGroupMembers;

-- Question 3: Tạo view có chứa câu hỏi có content quá dài và xóa chúng
CREATE VIEW LongContentQuestions AS
SELECT *
FROM Question
WHERE LENGTH(Content) = (SELECT MAX(LENGTH(Content)) 
						  FROM Question);

SELECT * 
FROM LongContentQuestions;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE VIEW DepartmentsWithMostEmployees AS
SELECT DepartmentID, COUNT(*) AS NumEmployees
FROM Account
GROUP BY DepartmentID
HAVING COUNT(*) = (
    SELECT MAX(EmployeeCount)
    FROM (
        SELECT COUNT(*) AS EmployeeCount
        FROM Account
        GROUP BY DepartmentID
    ) AS DepartmentCounts
);

SELECT * 
FROM DepartmentsWithMostEmployees;

-- Question 5: Tạo view có chứa tất cả các câu hỏi do user có họ "Nguyễn" tạo
CREATE VIEW NguyenQuestions AS
SELECT *
FROM Question
WHERE CreatorID 
IN (SELECT AccountID 
	FROM Account 
    WHERE FullName LIKE 'Nguyễn%');

SELECT * 
FROM NguyenQuestions;



