-- Tạo database Testing_System_Db;
CREATE DATABASE Testing_System_Db;

-- Tạo table Department
CREATE TABLE `Department`(
	DepartmentID	INT,
    DepartmentName	VARCHAR(255)
);

-- Tạo table Position
CREATE TABLE `Position`(
	PositionID		INT,
    PositionName	VARCHAR(255)
);

-- Tạo table Account
CREATE TABLE `Account`(
	AccountID		INT,
    Email 			VARCHAR(255),
    Username 		VARCHAR(255),
    FullName		VARCHAR(255),
	DepartmentID	INT,
    PositionID		INT,
    CreateDate		DATE
);

-- Tạo table Group
CREATE TABLE `Group`(
	GroupID			INT,
    GroupName		VARCHAR(255),
    CreatorID		INT,
    CreateDate		DATE
);

-- Tạo table GroupAccount
CREATE TABLE `GroupAccount`(
	GroupID			INT,
    AccountID		INT,
    JoinDate		DATE
);

-- Tạo table TypeQuestion
CREATE TABLE `TypeQuestion`(
	TypeID			INT,
    TypeName		VARCHAR(255)
);

-- Tạo table CategoryQuestion
CREATE TABLE `CategoryQuestion`(
	CategoryID		INT,
    CategoryName	VARCHAR(255)
);

-- Tạo table Question 
CREATE TABLE `Question`(
	QuestionID 		INT,
    Content 		VARCHAR(255),
    CategoryID		INT,
    TypeID			INT,
    CreatorID		INT,
    CreateDate		DATE
);

-- Tạo table Answer
CREATE TABLE `Answer`(
	AnswerID		INT,
    Content			VARCHAR(255),
    QuestionID		INT,
    isCorrect		BOOLEAN
);

-- Tạo table Exam
CREATE TABLE `Exam`(
	ExamID			INT,
    Code			VARCHAR(255),
    Title			VARCHAR(255),
    CategoryID		INT,
    Duration		DATE,
    CreatorID		INT,
    CreateDate		DATE
);

-- Tạo table ExamQuestion
CREATE TABLE `ExamQuestion`(
	ExamID			INT,
    QuestionID		INT
);