-- Question 1 & Question 2: Tối ưu và thêm constraint vào các table

-- Tạo database Testing_System_Db;
DROP DATABASE IF EXISTS Testing_System_Db;
CREATE DATABASE IF NOT EXISTS Testing_System_Db;
USE Testing_System_Db;

-- Tạo table Department
DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department`(
	DepartmentID	INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName	VARCHAR(255) NOT NULL
);

-- Tạo table Position
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	PositionID		INT AUTO_INCREMENT PRIMARY KEY,
    PositionName	VARCHAR(255) NOT NULL
);

-- Tạo table Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID		INT AUTO_INCREMENT PRIMARY KEY,
    Email 			VARCHAR(255) NOT NULL,
    Username 		VARCHAR(255) NOT NULL,
    FullName		VARCHAR(255) NOT NULL,
    DepartmentID	INT,
    PositionID		INT,
    CreateDate		DATE,
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID),
    FOREIGN KEY (DepartmentID) REFERENCES `Department`(DepartmentID)
);

-- Tạo table Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID			INT	AUTO_INCREMENT PRIMARY KEY,
    GroupName		VARCHAR(255) NOT NULL,
    CreatorID		INT,
    CreateDate		DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Tạo table GroupAccount
DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount`(
	GroupID			INT,
    AccountID		INT,
    JoinDate		DATE,
	FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

-- Tạo table TypeQuestion
DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion`(
	TypeID			INT AUTO_INCREMENT PRIMARY KEY,
    TypeName		VARCHAR(255) NOT NULL
);

-- Tạo table CategoryQuestion
DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion`(
	CategoryID		INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName	VARCHAR(255) NOT NULL
);

-- Tạo table Question 
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question`(
	QuestionID 		INT AUTO_INCREMENT PRIMARY KEY,
    Content 		TEXT NOT NULL,
    CategoryID		INT,
    TypeID			INT,
    CreatorID		INT,
    CreateDate		DATE,
    FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Tạo table Answer
DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer`(
	AnswerID		INT AUTO_INCREMENT PRIMARY KEY,
    Content			VARCHAR(255),
    QuestionID		INT,
    isCorrect		BOOLEAN,
	FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

-- Tạo table Exam
DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam`(
	ExamID			INT AUTO_INCREMENT PRIMARY KEY,
    Code			VARCHAR(255),
    Title			VARCHAR(255),
    CategoryID		INT,
    Duration		DATE,
    CreatorID		INT,
    CreateDate		DATE,
    FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Tạo table ExamQuestion
DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion`(
	ExamID			INT,
    QuestionID		INT,
    FOREIGN KEY (ExamID) REFERENCES `Exam`(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

-- Question 3: 
-- Chèn dữ liệu vào bảng Department
INSERT INTO `Department`(DepartmentName	)
VALUES 
						('Marketing'	),
						('Sale'			),
						('Bảo vệ'		),
						('Nhân sự'		),
						('Kỹ thuật'		),
						('Tài chính'	),
						('Phó giám đốc'	),
						('Giám đốc'		),
						('Thư ký'		),
						('Bán hàng'		);

-- Chèn dữ liệu vào bảng Position
INSERT INTO `Position`(PositionName	)
VALUES 
					('Dev'			),
					('Test'			),
					('Scrum Master'	),
					('PM'			);

-- Chèn dữ liệu vào bảng Account
INSERT INTO `Account`(Email				 ,  Username  , FullName     , DepartmentID, PositionID, CreateDate)
VALUES 
					('email1@example.com', 'username1', 'Full Name 1', 1           , 1         , '2024-05-05'),
					('email2@example.com', 'username2', 'Full Name 2', 2		   , 2         , '2024-05-05'),
					('email3@example.com', 'username3', 'Full Name 3', 3           , 3         , '2024-05-05'),
					('email4@example.com', 'username4', 'Full Name 4', 4           , 4         , '2024-05-05'),
					('email5@example.com', 'username5', 'Full Name 5', 5           , 1         , '2024-05-05'),
					('dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'			,   '6'			,   '3'		,'2020-04-05'),
                    ('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '7'			,   '2'		, NULL		),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '8'			,   '1'		,'2020-04-07'),
                    ('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');

-- Chèn dữ liệu vào bảng CategoryQuestion
INSERT INTO CategoryQuestion(CategoryID, CategoryName)
VALUES 
(1, N'Java'),
(2, N'.NET'),
(3, N'SQL'),
(4, N'Postman'),
(5, N'Ruby');

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