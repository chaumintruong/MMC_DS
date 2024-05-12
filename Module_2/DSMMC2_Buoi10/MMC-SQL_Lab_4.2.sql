USE  Testing_System_Db;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT AccountID, Username, Fullname, DepartmentName
FROM Account
INNER JOIN Department 
ON Account.DepartmentID = Department.DepartmentID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM Account
WHERE CreateDate > '2010-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT *
FROM Account
WHERE PositionID = (SELECT PositionID
					FROM Position
                    WHERE PositionName = 'Developer');
                    
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT Department.DepartmentName, COUNT(*) AS EmployeeCount
FROM Department
LEFT JOIN Account
ON Department.DepartmentID = Account.DepartmentID
GROUP BY Department.DepartmentID
HAVING EmployeeCount > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT Q.*, COUNT(Q.Content) AS SL
FROM Question Q
JOIN ExamQuestion EQ
ON Q.QuestionID = EQ.QuestionID
GROUP BY Q.QuestionID
HAVING SL = (SELECT MAX(CountQ)
			 FROM (SELECT COUNT(Q.QuestionID) AS CountQ
				   FROM ExamQuestion EQ
				   INNER JOIN Question Q 
				   ON EQ.QuestionID = Q.QuestionID
				   GROUP BY	Q.QuestionID) AS MaxContent);

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT CQ.CategoryName, COUNT(Q.CategoryID) AS QuestionCount
FROM CategoryQuestion CQ
LEFT JOIN Question Q
ON CQ.CategoryID = Q.CategoryID
GROUP BY CQ.CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT EQ.QuestionID, COUNT(EQ.ExamID) AS ExamCount
FROM ExamQuestion EQ
GROUP BY EQ. QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.*, COUNT(Q.QuestionID) AS AnswerCount
FROM Question Q
JOIN Answer A 
ON Q.QuestionID = A.QuestionID
GROUP BY Q.QuestionID
HAVING AnswerCount = (SELECT MAX(CountA)
					  FROM (SELECT COUNT(A.QuestionID) AS CountA
				      FROM Answer A
				      INNER JOIN Question Q 
				      ON A.QuestionID = Q.QuestionID
				      GROUP BY	Q.QuestionID) AS MaxContent);
                      
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT GA.GroupID, COUNT(A.AccountID) AS AccountCount
FROM GroupAccount GA
JOIN Account A 
ON GA.AccountID = A.AccountID
GROUP BY GA.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT Position.PositionName, COUNT(Account.PositionID) AS NumOfEmployees
FROM Position
LEFT JOIN Account ON Position.PositionID = Account.PositionID
GROUP BY Position.PositionID
HAVING COUNT(Account.PositionID) = (
    SELECT MIN(NumEmployees)
    FROM (
        SELECT COUNT(PositionID) AS NumEmployees
        FROM Account
        GROUP BY PositionID
    ) AS MinEmployees
);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT 
    D.DepartmentName,
    COUNT(CASE WHEN p.PositionName = 'Dev' THEN 1 END) AS DevCount,
    COUNT(CASE WHEN p.PositionName = 'Test' THEN 1 END) AS TestCount,
    COUNT(CASE WHEN p.PositionName = 'Scrum Master' THEN 1 END) AS ScrumMasterCount,
    COUNT(CASE WHEN p.PositionName = 'PM' THEN 1 END) AS PMCount
FROM 
    Department D
JOIN 
    Account A ON D.DepartmentID = A.DepartmentID
JOIN 
    Position P ON A.PositionID = P.PositionID
GROUP BY 
    D.DepartmentID;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT 
    Q.Content AS QuestionContent,
    TQ.TypeName AS QuestionType,
    A.Content AS AnswerContent,
    AC.Username AS CreatorUsername
FROM 
    Question Q
JOIN 
    TypeQuestion TQ ON Q.TypeID = TQ.TypeID
JOIN 
    Account AC ON Q.CreatorID = AC.AccountID
LEFT JOIN 
    Answer A ON Q.QuestionID = A.QuestionID;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT 
    TQ.TypeName,
    COUNT(Q.QuestionID) AS QuestionCount
FROM 
    TypeQuestion TQ
LEFT JOIN 
    Question Q ON TQ.TypeID = Q.TypeID
GROUP BY 
    TQ.TypeID;

-- Question 14: Lấy ra group không có account nào
SELECT 
    G.GroupName
FROM 
    GroupAccount GA
RIGHT JOIN 
    `Group` G ON GA.GroupID = G.GroupID
WHERE 
    GA.AccountID IS NULL;

-- Question 15: Lấy ra group không có account nào
SELECT G.GroupName
FROM `Group` G
LEFT JOIN GroupAccount GA 
ON G.GroupID = GA.GroupID
WHERE GA.AccountID IS NULL;

-- Question 16: Lấy ra question không có answer nào
SELECT Q.Content
FROM Question Q
LEFT JOIN Answer A
ON Q.QuestionID = A.QuestionID
WHERE A.AnswerID IS NULL;

-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT Account.*
FROM Account
JOIN GroupAccount ON Account.AccountID = GroupAccount.AccountID
WHERE GroupAccount.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT Account.*
FROM Account
JOIN GroupAccount ON Account.AccountID = GroupAccount.AccountID
WHERE GroupAccount.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
(SELECT Account.*
FROM Account
JOIN GroupAccount ON Account.AccountID = GroupAccount.AccountID
WHERE GroupAccount.GroupID = 1)

UNION

(SELECT Account.*
FROM Account
JOIN GroupAccount ON Account.AccountID = GroupAccount.AccountID
WHERE GroupAccount.GroupID = 2);


-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT `Group`.*
FROM `Group`
JOIN GroupAccount ON `Group`.GroupID = GroupAccount.GroupID
GROUP BY `Group`.GroupID
HAVING COUNT(GroupAccount.AccountID) > 5;

-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT `Group`.*
FROM `Group`
JOIN GroupAccount ON `Group`.GroupID = GroupAccount.GroupID
GROUP BY `Group`.GroupID
HAVING COUNT(GroupAccount.AccountID) < 7;

-- c) Ghép 2 kết quả từ câu a) và câu b)
(SELECT `Group`.*
FROM `Group`
JOIN GroupAccount ON `Group`.GroupID = GroupAccount.GroupID
GROUP BY `Group`.GroupID
HAVING COUNT(GroupAccount.AccountID) > 5)

UNION

(SELECT `Group`.*
FROM `Group`
JOIN GroupAccount ON `Group`.GroupID = GroupAccount.GroupID
GROUP BY `Group`.GroupID
HAVING COUNT(GroupAccount.AccountID) < 7);

