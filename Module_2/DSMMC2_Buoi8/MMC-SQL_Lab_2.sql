-- Question 1: Tối ưu lại cấu trúc database

-- Tạo Database IF NOT EXISTS
CREATE DATABASE IF NOT EXISTS Testing_System_Db;

-- Sử dụng Database
USE Testing_System_Db;

-- Tạo bảng Department
CREATE TABLE IF NOT EXISTS Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL
);

-- Tạo bảng Position
CREATE TABLE IF NOT EXISTS Position (
    PositionID INT AUTO_INCREMENT PRIMARY KEY,
    PositionName VARCHAR(255) NOT NULL
);

-- Tạo bảng Account
CREATE TABLE IF NOT EXISTS Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(255) NOT NULL,
    Username VARCHAR(255) NOT NULL,
    FullName VARCHAR(255) NOT NULL,
    DepartmentID INT,
    PositionID INT,
    CreateDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
);

-- Tạo bảng Group
CREATE TABLE IF NOT EXISTS `Group` (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(255) NOT NULL,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

-- Tạo bảng GroupAccount
CREATE TABLE IF NOT EXISTS GroupAccount (
    GroupID INT,
    AccountID INT,
    JoinDate DATE,
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Tạo bảng TypeQuestion
CREATE TABLE IF NOT EXISTS TypeQuestion (
    TypeID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(255) NOT NULL
);

-- Tạo bảng CategoryQuestion
CREATE TABLE IF NOT EXISTS CategoryQuestion (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

-- Tạo bảng Question
CREATE TABLE IF NOT EXISTS Question (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

-- Tạo bảng Answer
CREATE TABLE IF NOT EXISTS Answer (
    AnswerID INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    QuestionID INT,
    IsCorrect BOOLEAN,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- Tạo bảng Exam
CREATE TABLE IF NOT EXISTS Exam (
    ExamID INT AUTO_INCREMENT PRIMARY KEY,
    Code VARCHAR(255) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    CategoryID INT,
    Duration INT,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

-- Tạo bảng ExamQuestion
CREATE TABLE IF NOT EXISTS ExamQuestion (
    ExamID INT,
    QuestionID INT,
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- Question 2: Thêm ràng buộc vào các database

-- Tạo Database IF NOT EXISTS
CREATE DATABASE IF NOT EXISTS Testing_System_Db;

-- Sử dụng Database
USE Testing_System_Db;

-- Tạo bảng Department
CREATE TABLE IF NOT EXISTS Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL
);

-- Tạo bảng Position
CREATE TABLE IF NOT EXISTS Position (
    PositionID INT AUTO_INCREMENT PRIMARY KEY,
    PositionName VARCHAR(255) NOT NULL
);

-- Tạo bảng Account
CREATE TABLE IF NOT EXISTS Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(255) NOT NULL,
    Username VARCHAR(255) NOT NULL,
    FullName VARCHAR(255) NOT NULL,
    DepartmentID INT,
    PositionID INT,
    CreateDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
);

-- Tạo bảng Group
CREATE TABLE IF NOT EXISTS `Group` (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(255) NOT NULL,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

-- Tạo bảng GroupAccount
CREATE TABLE IF NOT EXISTS GroupAccount (
    GroupID INT,
    AccountID INT,
    JoinDate DATE,
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    PRIMARY KEY (GroupID, AccountID) -- Thêm primary key cho bảng GroupAccount
);

-- Tạo bảng TypeQuestion
CREATE TABLE IF NOT EXISTS TypeQuestion (
    TypeID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(255) NOT NULL
);

-- Tạo bảng CategoryQuestion
CREATE TABLE IF NOT EXISTS CategoryQuestion (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

-- Tạo bảng Question
CREATE TABLE IF NOT EXISTS Question (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

-- Tạo bảng Answer
CREATE TABLE IF NOT EXISTS Answer (
    AnswerID INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    QuestionID INT,
    IsCorrect BOOLEAN,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- Tạo bảng Exam
CREATE TABLE IF NOT EXISTS Exam (
    ExamID INT AUTO_INCREMENT PRIMARY KEY,
    Code VARCHAR(255) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    CategoryID INT,
    Duration INT,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

-- Tạo bảng ExamQuestion
CREATE TABLE IF NOT EXISTS ExamQuestion (
    ExamID INT,
    QuestionID INT,
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID),
    PRIMARY KEY (ExamID, QuestionID) -- Thêm primary key cho bảng ExamQuestion
);


-- Question 3: 

-- Chèn dữ liệu vào bảng Department
INSERT INTO Department(DepartmentID, DepartmentName)
VALUES 
(1, N'Marketing'),
(2, N'Sale'),
(3, N'Bảo vệ'),
(4, N'Nhân sự'),
(5, N'Kỹ thuật'),
(6, N'Tài chính'),
(7, N'Phó giám đốc'),
(8, N'Giám đốc'),
(9, N'Thư ký'),
(10, N'Bán hàng');

-- Chèn dữ liệu vào bảng Position
INSERT INTO `Position`(PositionID, PositionName)
VALUES 
(1, N'Dev'),
(2, N'Test'),
(3, N'Scrum Master'),
(4, N'PM');

-- Chèn dữ liệu vào bảng CategoryQuestion
INSERT INTO CategoryQuestion(CategoryID, CategoryName)
VALUES 
(1, N'Java'),
(2, N'.NET'),
(3, N'SQL'),
(4, N'Postman'),
(5, N'Ruby');

-- Chèn dữ liệu vào bảng Account
INSERT INTO Account(Email, Username, FullName, DepartmentID, PositionID, CreateDate)
VALUES 
('email1@example.com', 'username1', 'Full Name 1', 1, 1, '2024-05-05'),
('email2@example.com', 'username2', 'Full Name 2', 2, 2, '2024-05-05'),
('email3@example.com', 'username3', 'Full Name 3', 3, 3, '2024-05-05'),
('email4@example.com', 'username4', 'Full Name 4', 4, 4, '2024-05-05'),
('email5@example.com', 'username5', 'Full Name 5', 5, 1, '2024-05-05');

-- Chèn dữ liệu vào bảng Group
INSERT INTO `Group`(GroupName, CreatorID, CreateDate)
VALUES 
('Group 1', 1, '2024-05-05'),
('Group 2', 2, '2024-05-05'),
('Group 3', 3, '2024-05-05'),
('Group 4', 4, '2024-05-05'),
('Group 5', 5, '2024-05-05');

-- Chèn dữ liệu vào bảng TypeQuestion
INSERT INTO TypeQuestion(TypeID, TypeName)
VALUES 
(1, N'Essay'),
(2, N'Multiple-Choice');

-- Chèn dữ liệu vào bảng CategoryQuestion
INSERT INTO CategoryQuestion(CategoryID, CategoryName)
VALUES 
(1, N'Java'),
(2, N'.NET'),
(3, N'SQL'),
(4, N'Postman'),
(5, N'Ruby');

-- Chèn dữ liệu vào bảng Question
INSERT INTO Question(Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES 
('Content 1', 1, 1, 1, '2024-05-05'),
('Content 2', 2, 2, 2, '2024-05-05'),
('Content 3', 3, 1, 3, '2024-05-05'),
('Content 4', 4, 2, 4, '2024-05-05'),
('Content 5', 5, 1, 5, '2024-05-05');

-- Chèn dữ liệu vào bảng Answer
INSERT INTO Answer(Content, QuestionID, IsCorrect)
VALUES 
('Answer 1', 1, true),
('Answer 2', 2, false),
('Answer 3', 3, true),
('Answer 4', 4, false),
('Answer 5', 5, true);

-- Chèn dữ liệu vào bảng Exam
INSERT INTO Exam(Code, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES 
('Code 1', 'Title 1', 1, 60, 1, '2024-05-05'),
('Code 2', 'Title 2', 2, 60, 2, '2024-05-05'),
('Code 3', 'Title 3', 3, 60, 3, '2024-05-05'),
('Code 4', 'Title 4', 4, 60, 4, '2024-05-05'),
('Code 5', 'Title 5', 5, 60, 5, '2024-05-05');

-- Chèn dữ liệu vào bảng ExamQuestion
INSERT INTO ExamQuestion(ExamID, QuestionID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


