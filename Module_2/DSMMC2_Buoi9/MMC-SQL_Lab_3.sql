-- Question 1:
-- Chèn dữ liệu vào bảng Department
INSERT INTO `Department`(DepartmentName					)
VALUES 
						(N'Kế toán'						),
						(N'Phòng kỹ thuật'				),
						(N'Quản lý sản xuất'			),
						(N'Dịch vụ khách hàng'			),
						(N'Tư vấn kinh doanh'			),
						(N'Quản trị nhân sự'			),
						(N'Phòng kinh doanh'			),
						(N'Tiếp thị và PR'				),
						(N'Trợ lý điều hành'			),
						(N'Nghiên cứu và phát triển'	);
                        
-- -- Chèn dữ liệu vào bảng Position
INSERT INTO `Position`	(PositionName				)
VALUES 
						('Technical Staff'			),
						('Sales Specialist'			),
						('Project Manager'			),
						('Software Engineer'		),
						('Financial Analyst'		),
						('Marketing Specialist'		),
						('HR Specialist'			),
						('Department Manager'		),
						('Technical Support Staff'	),
						('Consultant'				),
						('Database Administrator'	),
						('IT Support'				),
						('UX Designer'				),
                        ('System Architect'         ),
                        ('Product Manager'			),
                        ('Business Analyst'			);

-- Chèn dữ liệu vào bảng Account
INSERT INTO Account(Email				 		,  Username  	, FullName     			, DepartmentID		, PositionID	, CreateDate  )
VALUES 
					('alice.johnson@example.com', 'alicejohnson', 'Alice Johnson'		, 11				, 12			, '2023-01-15'),
					('bob.smith@example.com'	, 'bobsmith'	, 'Bob Smith'			, 12				, 13			, '2023-02-20'),
					('charlie.brown@example.com', 'charliebrown', 'Charlie Brown'		, 13				, 14			, '2023-03-25'),
					('diana.prince@example.com'	, 'dianaprince'	, 'Diana Prince'		, 14				, 15			, '2023-04-30'),
					('edward.king@example.com'	, 'edwardking'	, 'Edward King'			, 15				, 16			, '2023-05-05'),
					('fiona.queen@example.com'	, 'fionaqueen'	, 'Fiona Queen'			, 16				, 17			, '2023-06-10'),
					('george.miller@example.com', 'georgemiller', 'George Miller'		, 17				, 18			, '2023-07-15'),
					('hannah.baker@example.com'	, 'hannahbaker'	, 'Hannah Baker'		, 18				, 19			, '2023-08-20'),
					('ian.clark@example.com'	, 'ianclark'	, 'Ian Clark'			, 19				, 20			, '2023-09-25'),
					('julia.roberts@example.com', 'juliaroberts', 'Julia Roberts'		, 20				, 11			, '2023-10-30');
	
-- Chèn dữ liệu vào bảng Group
INSERT INTO `Group`	(  GroupName						, CreatorID		, CreateDate  )
VALUES    			(N'Testing Team'					, 11			, '2023-01-15'),
					(N'Development Squad'				, 12			, '2023-02-20'),
					(N'Sales Force'						, 13			, '2023-03-25'),
					(N'Marketing Crew'					, 14			, '2023-04-30'),
					(N'Customer Support Team'			, 15			, '2023-05-05'),
					(N'HR Department'					, 16			, '2023-06-10'),
					(N'Finance Group'					, 17			, '2023-07-15'),
					(N'Project Management Office'		, 18			, '2023-08-20'),
					(N'Research and Development Team'	, 19			, '2023-09-25'),
					(N'Executive Board'					, 20			, '2023-10-30');


-- Chèn dữ liệu vào bảng GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	11		,    18		,'2019-03-05'),
							(	11		,    12		,'2019-06-07'),
							(	13		,    19		,'2020-03-09'),
							(	13		,    14		,'2020-07-10'),
							(	15		,    15		,'2020-12-28'),
							(	12		,    16		,'2021-04-06'),
							(	12		,    17		,'2021-05-27'),
							(	18		,    13		,'2021-06-08'),
							(	14		,    20		,'2023-04-09'),
							(	20		,    11		,'2023-10-10');

-- Chèn dữ liệu vào bảng TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('True/False'		),
							('Fill in the Blank'),
							('Matching'			),
							('Short Answer'		),
							('Diagram Labeling'	),
							('Case Study'		),
							('Programming'		),
							('Code Review'		),
							('Oral Exam'		),
							('Problem Solving'	);

-- Chèn dữ liệu vào bảng CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('JavaScript'   ),
									('HTML/CSS'		),
									('ReactJS'		),
									('NodeJS'		),
									('Swift'		),
									('Kotlin'		),
									('TypeScript'	),
									('Go'			),
									('Scala'		),
									('Angular'		);

-- Chèn dữ liệu vào bảng Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về JavaScript', 1, 1, 11, '2023-01-15'),
						(N'Câu hỏi về HTML/CSS', 2, 2, 12, '2023-02-20'),
						(N'Câu hỏi về ReactJS', 3, 1, 13, '2023-03-25'),
						(N'Câu hỏi về NodeJS', 4, 2, 14, '2023-04-30'),
						(N'Câu hỏi về Swift', 5, 1, 15, '2023-05-05'),
						(N'Câu hỏi về Kotlin', 6, 2, 16, '2023-06-10'),
						(N'Câu hỏi về TypeScript', 7, 1, 17, '2023-07-15'),
						(N'Câu hỏi về Go', 8, 2, 18, '2023-08-20'),
						(N'Câu hỏi về Scala', 9, 1, 19, '2023-09-25'),
						(N'Câu hỏi về Angular', 10, 2, 20, '2023-10-30');

-- Chèn dữ liệu vào bảng Answer
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời JavaScript', 1, 1),
					(N'Trả lời JS', 1, 0),
					(N'Trả lời HTML/CSS', 2, 1),
					(N'Trả lời CSS', 2, 0),
					(N'Trả lời ReactJS', 3, 1),
					(N'Trả lời 11', 3, 0),
					(N'Trả lời NodeJS', 4, 1),
					(N'Trả lời Scala', 4, 0),
					(N'Trả lời Swift', 5, 1),
					(N'Trả lời Go', 5, 0);

-- Chèn dữ liệu vào bảng Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ011', N'Đề thi JavaScript', 1, 60, 11, '2023-01-15'),
					('VTIQ012', N'Đề thi HTML/CSS', 2, 45, 12, '2023-02-20'),
					('VTIQ013', N'Đề thi ReactJS', 3, 90, 13, '2023-03-25'),
					('VTIQ014', N'Đề thi NodeJS', 4, 75, 14, '2023-04-30'),
					('VTIQ015', N'Đề thi Swift', 5, 60, 15, '2023-05-05'),
					('VTIQ016', N'Đề thi Kotlin', 6, 45, 16, '2023-06-10'),
					('VTIQ017', N'Đề thi TypeScript', 7, 90, 17, '2023-07-15'),
					('VTIQ018', N'Đề thi Go', 8, 75, 18, '2023-08-20'),
					('VTIQ019', N'Đề thi Scala', 9, 60, 19, '2023-09-25'),
					('VTIQ020', N'Đề thi Angular', 10, 45, 20, '2023-10-30');

-- Chèn dữ liệu vào bảng ExamQuestion
INSERT INTO `ExamQuestion`(ExamID	, QuestionID	) 
VALUES 					(11, 15),
						(12, 17),
						(13, 12),
						(14, 18),
						(15, 11),
						(16, 16),
						(17, 19),
						(18, 13),
						(19, 20),
						(20, 14);

-- Question 2: Lấy ra tất cả các phòng ban Department
SELECT * 
FROM Department;

-- Question 3: Lấy ra id của phòng ban "Sale"
SELECT DepartmentID 
FROM Department 
WHERE DepartmentName = 'Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT *
FROM `Account`
WHERE LENGTH(FullName) = (SELECT MAX(LENGTH(FullName)) 
						  FROM `Account`);

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT * 
FROM Account 
WHERE DepartmentID = 3 
ORDER BY LENGTH(FullName) = (SELECT MAX(LENGTH(FullName)) 
						  FROM `Account`);

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT GroupName 
FROM `Group` 
WHERE CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID 
FROM Answer 
GROUP BY QuestionID 
HAVING COUNT(*) >= 4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT Code
FROM Exam 
WHERE Duration >= 60 AND CreateDate < '2019-12-20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT *
FROM `Group` 
ORDER BY CreateDate 
DESC LIMIT 5;


-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(*) 
FROM Account 
WHERE DepartmentID = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * 
FROM Account 
WHERE FullName LIKE 'D%o';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE 
FROM ExamQuestion 
WHERE ExamID 
IN (SELECT ExamID 
	FROM Exam 
    WHERE CreateDate < '2019-12-20');

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE 
FROM Answer 
WHERE QuestionID 
IN (SELECT QuestionID 
	FROM Question 
    WHERE Content LIKE 'câu hỏi%');

-- Question 14: Update thông tin của account có id = 5
UPDATE Account 
SET FullName = 'Lô Văn Đề', Email = 'lo.vande@mmc.edu.vn'
WHERE AccountID = 5;

-- Question 15: Update account có id = 5 sẽ thuộc group có id = 4
UPDATE GroupAccount 
SET GroupID = 4 
WHERE AccountID = 5;
