-- Question 1 & Question 2: Tối ưu và thêm constraint vào các table

-- Tạo database Testing_System_Db;
DROP DATABASE IF EXISTS Testing_System_Db;
CREATE DATABASE IF NOT EXISTS Testing_System_Db;
USE Testing_System_Db;

-- Tạo table Department
DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department`(
	DepartmentID	INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName	NVARCHAR(255) NOT NULL
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
    DepartmentID	INT NOT NULL,
    PositionID		INT NOT NULL,
    CreateDate		DATE,
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID),
    FOREIGN KEY (DepartmentID) REFERENCES `Department`(DepartmentID)
);

-- Tạo table Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID			INT	AUTO_INCREMENT PRIMARY KEY,
    GroupName		VARCHAR(255) NOT NULL,
    CreatorID		INT NOT NULL,
    CreateDate		DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Tạo table GroupAccount
DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount`(
	GroupID			INT NOT NULL,
    AccountID		INT NOT NULL,
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
    CategoryID		INT NOT NULL,
    TypeID			INT NOT NULL,
    CreatorID		INT NOT NULL,
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
    QuestionID		INT NOT NULL,
    isCorrect		BOOLEAN,
	FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

-- Tạo table Exam
DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam`(
	ExamID			INT AUTO_INCREMENT PRIMARY KEY,
    Code			VARCHAR(255),
    Title			VARCHAR(255),
    CategoryID		INT NOT NULL,
    Duration		INT NOT NULL,
    CreatorID		INT NOT NULL,
    CreateDate		DATE,
    FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Tạo table ExamQuestion
DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion`(
	ExamID			INT NOT NULL,
    QuestionID		INT NOT NULL,
    FOREIGN KEY (ExamID) REFERENCES `Exam`(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

-- Question 3: 
-- Chèn dữ liệu vào bảng Department
INSERT INTO `Department`(DepartmentName	)
VALUES 
						(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư ký'		),
						(N'Bán hàng'	);

-- Chèn dữ liệu vào bảng Position
INSERT INTO `Position`(PositionName	)
VALUES 
					('Dev'			),
					('Test'			),
					('Scrum Master'	),
					('PM'			);

-- Chèn dữ liệu vào bảng Account
INSERT INTO `Account`(Email				 		,  Username  	, FullName     			, DepartmentID	, PositionID, CreateDate)
VALUES 
					('minhchou2112@gmail.com'	, 'minchou'		, 'Truong Minh Chau'	, 1           	, 1         , '2024-05-05'),
					('john.doe@example.com'		, 'johndoe'		, 'John Doe'			, 2		   		, 2         , '2023-05-20'),
					('jane.smith@example.com'	, 'janesmith'	, 'Jane Smith'			, 3           	, 3         , '2022-05-18'),
					('sarah.connor@example.com'	, 'sarahconnor'	, 'Sarah Connor'		, 4           	, 4         , '2021-05-16'),
					('peter.parker@example.com'	, 'peterparker'	, 'Peter Parker'		, 5           	, 1         , '2022-05-11'),
					('emma.watson@example.com'	, 'emmawatson'	, 'Emma Watson'			, 6				, 3			, '2024-05-14'),
                    ('bruce.wayne@example.com'	, 'brucewayne'	, 'Bruce Wayne'			, 7				, 2			, NULL		  ),
                    ('lisa.simpson@example.com'	, 'lisasimpson'	, 'Lisa Simpson'		, 8				, 1			, '2020-04-07'),
                    ('tony.stark@example.com'	, 'tonystark'	, 'Tony Stark'			, 9				, 2			, '2023-04-07'),
                    ('harry.potter@example.com'	, 'harrypotter'	, 'Harry Potter'		, 10			, 1			, '2020-04-09');

-- Chèn dữ liệu vào bảng Group
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUES 				(N'Testing System'		,   5			,'2019-03-05'),
					(N'Development'			,   1			,'2020-03-07'),
                    (N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (N'VTI Sale 02'			,   3			,'2020-03-10'),
                    (N'VTI Sale 03'			,   4			,'2020-03-28'),
                    (N'VTI Creator'			,   6			,'2020-04-06'),
                    (N'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (N'Management'			,   8			,'2020-04-08'),
                    (N'Chat with love'		,   9			,'2020-04-09'),
                    (N'Vi Ti Ai'			,   10			,'2020-04-10');


-- Chèn dữ liệu vào bảng GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');

-- Chèn dữ liệu vào bảng TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	);

-- Chèn dữ liệu vào bảng CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);

-- Chèn dữ liệu vào bảng Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về R'	,	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Chèn dữ liệu vào bảng Answer
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		),
                    (N'Trả lời 06'	,   3			,	1		),
                    (N'Trả lời 07'	,   4			,	0		),
                    (N'Trả lời 08'	,   8			,	0		),
                    (N'Trả lời 09'	,   9			,	1		),
                    (N'Trả lời 10'	,   10			,	1		);

-- Chèn dữ liệu vào bảng Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');

-- Chèn dữ liệu vào bảng ExamQuestion
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 