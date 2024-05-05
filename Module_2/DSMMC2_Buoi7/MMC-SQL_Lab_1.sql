-- Tạo Database
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
    FOREIGN KEY (PositionID) REFERENCES Position(PositionID)
);

-- Tạo bảng Group
CREATE TABLE IF NOT EXISTS Group (
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
    FOREIGN KEY (GroupID) REFERENCES Group(GroupID),
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
