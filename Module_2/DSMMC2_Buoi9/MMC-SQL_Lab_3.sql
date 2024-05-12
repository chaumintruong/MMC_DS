-- Question 1: Thêm ít nhất 10 record vào mỗi table
-- Thêm records vào table Department
INSERT INTO Department(DepartmentName) VALUES 
('Sale'), ('Marketing'), ('IT'), ('HR'), ('Finance'), 
('Administration'), ('Production'), ('Customer Service'), ('Research'), ('Quality Control');

-- Thêm records vào table Position
INSERT INTO Position(PositionName) VALUES 
('Manager'), ('Assistant Manager'), ('Staff'), ('Intern'), ('Director'), 
('Coordinator'), ('Supervisor'), ('Analyst'), ('Engineer'), ('Consultant');

-- Thêm records vào table Account
INSERT INTO Account(Email, Username, FullName, DepartmentID, PositionID, CreateDate) VALUES 
('user1@example.com', 'user1', 'John Doe', 1, 3, '2023-01-01'),
('user2@example.com', 'user2', 'Jane Smith', 2, 4, '2023-02-15'),
('user3@example.com', 'user3', 'Michael Johnson', 3, 5, '2023-03-20'),
('user4@example.com', 'user4', 'Emily Brown', 4, 2, '2023-04-10'),
('user5@example.com', 'user5', 'Christopher Lee', 5, 1, '2023-05-05'),
('user6@example.com', 'user6', 'Amanda Wilson', 1, 3, '2023-06-18'),
('user7@example.com', 'user7', 'Daniel Martinez', 2, 4, '2023-07-22'),
('user8@example.com', 'user8', 'Sarah Taylor', 3, 5, '2023-08-30'),
('user9@example.com', 'user9', 'Matthew Anderson', 4, 2, '2023-09-12'),
('user10@example.com', 'user10', 'Jessica Moore', 5, 1, '2023-10-25');

-- Thêm records vào table Group
INSERT INTO Group(GroupName, CreatorID, CreateDate) VALUES 
('Group 1', 1, '2023-01-05'),
('Group 2', 2, '2023-02-20'),
('Group 3', 3, '2023-03-25'),
('Group 4', 4, '2023-04-15'),
('Group 5', 5, '2023-05-10'),
('Group 6', 1, '2023-06-30'),
('Group 7', 2, '2023-07-28'),
('Group 8', 3, '2023-08-22'),
('Group 9', 4, '2023-09-18'),
('Group 10', 5, '2023-10-12');

-- Thêm records vào table TypeQuestion
INSERT INTO TypeQuestion(TypeName) VALUES 
('Multiple Choice'), ('Essay'), ('True/False'), ('Fill in the Blank'), ('Matching');

-- Thêm records vào table CategoryQuestion
INSERT INTO CategoryQuestion(CategoryName) VALUES 
('SQL'), ('Java'), ('Python'), ('C++'), ('HTML/CSS'), 
('JavaScript'), ('Data Structures'), ('Algorithms'), ('Networking'), ('Security');

-- Thêm records vào table Question
INSERT INTO Question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES 
('What is SQL?', 1, 1, 1, '2023-01-10'),
('What is Java?', 2, 1, 2, '2023-02-25'),
('What is Python?', 3, 1, 3, '2023-03-30'),
('What is C++?', 4, 1, 4, '2023-04-20'),
('What is HTML?', 5, 1, 5, '2023-05-15'),
('What is JavaScript?', 6, 1, 1, '2023-06-28'),
('What are Data Structures?', 7, 1, 2, '2023-07-10'),
('What are Algorithms?', 8, 1, 3, '2023-08-05'),
('What is Networking?', 9, 1, 4, '2023-09-22'),
('What is Security?', 10, 1, 5, '2023-10-18');

-- Thêm records vào table Answer
INSERT INTO Answer(Content, QuestionID, IsCorrect) VALUES 
('Structured Query Language', 1, 1),
('A programming language', 2, 1),
('A high-level programming language', 3, 1),
('A general-purpose programming language', 4, 1),
('Hypertext Markup Language', 5, 1),
('A programming language for web development', 6, 1),
('Data organization and storage techniques', 7, 1),
('A step-by-step procedure for calculations', 8, 1),
('A process of building, implementing, and maintaining networks', 9, 1),
('Protection of computer systems and data from theft or damage', 10, 1);

-- Thêm records vào table Exam
INSERT INTO Exam(Code, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES 
('EXAM01', 'SQL Fundamentals', 1, 60, 1, '2023-01-20'),
('EXAM02', 'Java Basics', 2, 60, 2, '2023-02-28'),
('EXAM03', 'Python Essentials', 3, 60, 3, '2023-03-25'),
('EXAM04', 'C++ Fundamentals', 4, 60, 4, '2023-04-15'),
('EXAM05', 'HTML/CSS Mastery', 5, 60, 5, '2023-05-10'),
('EXAM06', 'JavaScript Proficiency', 6, 60, 1, '2023-06-30'),
('EXAM07', 'Data Structures Exam', 7, 60, 2, '2023-07-28'),
('EXAM08', 'Algorithms Assessment', 8, 60, 3, '2023-08-22'),
('EXAM09', 'Networking Quiz', 9, 60, 4, '2023-09-18'),
('EXAM10', 'Security Test', 10, 60, 5, '2023-10-12');

-- Thêm records vào table ExamQuestion
INSERT INTO ExamQuestion(ExamID, QuestionID) VALUES 
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), 
(2, 6), (2, 7), (2, 8), (2, 9), (2, 10), 
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), 
(4, 6), (4, 7), (4, 8), (4, 9), (4, 10), 
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), 
(6, 6), (6, 7), (6, 8), (6, 9), (6, 10), 
(7, 1), (7, 2), (7, 3), (7, 4), (7, 5), 
(8, 6), (8, 7), (8, 8), (8, 9), (8, 10), 
(9, 1), (9, 2), (9, 3), (9, 4), (9, 5), 
(10, 6), (10, 7), (10, 8), (10, 9), (10, 10);

-- Question 2: Lấy ra tất cả các phòng ban Department
SELECT * FROM Department;

-- Question 3: Lấy ra id của phòng ban "Sale"
SELECT DepartmentID FROM Department WHERE DepartmentName = 'Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT * FROM Account WHERE LENGTH(FullName) = MAX(LENGTH(FullName));

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT * FROM Account WHERE DepartmentID = 3 ORDER BY LENGTH(FullName) DESC LIMIT 1;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT GroupName FROM `Group` WHERE CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID FROM Answer GROUP BY QuestionID HAVING COUNT(*) >= 4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT ExamID FROM Exam WHERE Duration >= 60 AND CreateDate < '2019-12-20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `Group` ORDER BY CreateDate DESC LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(*) FROM Account WHERE DepartmentID = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM Account WHERE FullName LIKE 'D%o';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM Exam WHERE CreateDate < '2019-12-20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE FROM Question WHERE Content LIKE 'câu hỏi%';

-- Question 14: Update thông tin của account có id = 5
UPDATE Account SET FullName = 'Lô Văn Đề', Email = 'lo.vande@mmc.edu.vn' WHERE AccountID = 5;

-- Question 15: Update account có id = 5 sẽ thuộc group có id = 4
UPDATE Account SET GroupID = 4 WHERE AccountID = 5;
