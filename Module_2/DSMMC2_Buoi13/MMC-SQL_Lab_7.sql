USE Testing_System_Db;

-- Question 1. Tạo Trigger không cho phép User nhập vào Group có Ngày tạo trước 1 năm trước
DROP    TRIGGER IF EXISTS   trg_BeforeInserGroup;
DELIMITER $$
CREATE  TRIGGER             trg_BeforeInserGroup
BEFORE INSERT ON `Group`
FOR EACH ROW
BEGIN
    DECLARE v_one_year_ago DATETIME;
    SET     v_one_year_ago = DATE_SUB(NOW(), INTERVAL 1 YEAR);

    IF NEW.CreateDate < v_one_year_ago THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'CreateDate cannot be earlier than one year ago';
    END IF;
END $$
DELIMITER ;

-- Question 2. Tạo Trigger không cho phép User thêm bất kỳ User nào vào Phòng "Human Resources" nữa, khi thêm thì hiện ra thông báo "Department "Human Resources" cannot add more user"
DROP    TRIGGER IF EXISTS   trg_BeforeInsertUser;
DELIMITER $$
CREATE  TRIGGER             trg_BeforeInsertUser
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
    IF NEW.DepartmentID =   (SELECT DepartmentID
                            FROM    Department
                            WHERE   DepartmentName = 'Human Resources'
                            ) THEN
        SIGNAL SQLSTATE  '45002'
        SET MESSAGE_TEXT = 'Department "Human Resources" cannot add more user';
    END IF;
END $$
DELIMITER ;

-- Question 3. Cấu hình một Group có nhiều nhất 5 User
DROP    TRIGGER IF EXISTS trg_BeforeInsertGroupAccount;
DELIMITER $$
CREATE  TRIGGER           trg_BeforeInsertGroupAccount
BEFORE INSERT ON `GroupAccount`
FOR EACH ROW
BEGIN
    DECLARE user_count INT;
    SET user_count =    (SELECT     COUNT(*)
                        FROM        GroupAccount
                        WHERE       GroupID = NEW.GroupID
                        );
    IF user_count > 5 THEN
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'Cannot add more than 5 User to the Group';
    END IF;
END $$
DELIMITER ;

-- Question 4. Cấu hình một Exam có nhiều nhất 5 Question
DROP    TRIGGER IF EXISTS trg_BeforeInsertExamQuestion;
DELIMITER $$
CREATE  TRIGGER           trg_BeforeInsertExamQuestion
BEFORE INSERT ON `ExamQuestion`
FOR EACH ROW
BEGIN
    DECLARE question_count INT;

    SET question_count =    (SELECT COUNT(*)   
                            FROM    `ExamQuestion`
                            WHERE   ExamID = NEW.ExamID
                            );
    
    IF question_count > 5 THEN
        SIGNAL SQLSTATE '45004'
        SET MESSAGE_TEXT = 'Maximum questions per exam exceeded. Limit: 5';
    END IF;
END $$
DELIMITER ;

-- Question 5. Tạo Trigger không cho User xóa tài khoản có Email là admin@gmail.com (các tài khoản khác có thể được xóa và sẽ xóa tất cả các thông tin liên quan tới User đó)
DROP    TRIGGER IF EXISTS   trg_PreventAdminDelete;
DELIMITER $$
CREATE  TRIGGER             trg_PreventAdminDelete
BEFORE DELETE ON `Account`
FOR EACH ROW
BEGIN
    IF OLD.Email = 'admin@gmail.com' THEN
        SIGNAL SQLSTATE '45005'
        SET MESSAGE_TEXT = 'Cannot delete admin account';
    END IF;
END $$
DELIMITER ;

-- Question 6. Không dùng cấu hình Default cho Field DepartmentID của bảng Account, hãy tạo Trigger cho phép User khi tạo Account không điền vào DepartmentID thì sẽ được phân vào phòng ban "Phòng chờ"
DROP    TRIGGER IF EXISTS   trg_DefaultDepartmentOnInsert;
DELIMITER $$
CREATE  TRIGGER             trg_DefaultDepartmentOnInsert
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
    DECLARE default_deptID INT;

    INSERT INTO `Department` (DepartmentName)
    SELECT      'Phòng chờ'
    WHERE       NOT EXISTS (SELECT  1
                            FROM    `Department`
                            WHERE   DepartmentName = 'Phòng chờ'
                            );

    SELECT  DepartmentID INTO default_deptID
    FROM    `Department`
    WHERE   DepartmentName = 'Phòng chờ'
    LIMIT   1;

    IF NEW.DepartmentID IS NULL THEN
        SET NEW.DepartmentID = default_deptID;
    END IF;
END $$
DELIMITER ;

-- Question 7. Cấu hình 1 Bài thi chỉ cho phép User tạo tối đa 4 Answers cho mỗi Question, trong đó có tối đa 2 đáp án đúng
DROP    TRIGGER IF EXISTS   trg_ValidateAnswers;
DELIMITER $$
CREATE  TRIGGER             trg_ValidateAnswers
BEFORE INSERT ON `ExamQuestion`
FOR EACH ROW
BEGIN
    DECLARE answer_count            INT;
    DECLARE correct_answer_count    INT;

    SELECT  COUNT(a.AnswerID)   , SUM(a.isCorrect = TRUE)
    INTO    answer_count        , correct_answer_count
    FROM    `Answer` AS a
    WHERE   a.QuestionID = NEW.QuestionID;

    IF answer_count >= 4 THEN
        SIGNAL SQLSTATE '45007'
        SET MESSAGE_TEXT = 'Each question can have a maximum of 4 answers.';
    END IF;

    IF correct_answer_count >= 2 THEN
        SIGNAL SQLSTATE '45007'
        SET MESSAGE_TEXT = 'Each question can have a maximum of 2 correct answers.';
    END IF;
END $$
DELIMITER ;

-- Question 9: Viết Trigger không cho phép User xóa Bài thi mới tạo được 2 ngày
DROP    TRIGGER IF EXISTS   trg_PreventDeleteRecentExams;
DELIMITER $$
CREATE  TRIGGER             trg_PreventDeleteRecentExams
BEFORE DELETE ON `Exam`
FOR EACH ROW
BEGIN
    IF (OLD.CreateDate >= NOW() - INTERVAL 2 DAY) THEN
        SIGNAL SQLSTATE '45008'
        SET MESSAGE_TEXT = 'Cannot  delete exams within the last 2 days';
    END IF;
END $$
DELIMITER ;

-- Question 10. Viết Trigger cho phép User chỉ được Update, Delete các Question khi nó chưa nằm trong Exam nào
DROP    TRIGGER IF EXISTS   trg_RestrictUpdateOnQuestion;
DELIMITER $$
CREATE  TRIGGER             trg_RestrictUpdateOnQuestion
BEFORE UPDATE ON `Question`
FOR EACH ROW
BEGIN
    DECLARE exam_count INT;

    SELECT  COUNT(*) INTO exam_count
    FROM    `ExamQuestion`
    WHERE   QuestionID = OLD.QuestionID;
    
    IF exam_count > 0 THEN
        SIGNAL SQLSTATE '45010'
        SET MESSAGE_TEXT = 'Update not allowed: The question is part of an exam.';
    END IF;
END $$
DELIMITER ;

DROP    TRIGGER IF EXISTS   trg_RestrictDeleteOnQuestion;
DELIMITER $$
CREATE  TRIGGER             trg_RestrictDeleteOnQuestion
BEFORE DELETE ON `Question`
FOR EACH ROW
BEGIN
    DECLARE exam_count INT;

    SELECT  COUNT(*) INTO exam_count
    FROM    `ExamQuestion`
    WHERE   QuestionID = OLD.QuestionID;
    
    IF exam_count > 0 THEN
        SIGNAL SQLSTATE '45010'
        SET MESSAGE_TEXT = 'Delete not allowed: The question is part of an exam.';
    END IF;
END $$
DELIMITER ;

-- Question 11. Lấy ra thông tin Exam: nếu Duration <= 30 đổi thành "Short time", nếu 30 < Duration <= 60 đổi thành "Medium time", nếu Duration > 60 đổi thành "Long time"
SELECT  ExamID, Title,
        CASE
            WHEN Duration <= 30 THEN 'Short time'
            WHEN Duration <= 60 THEN 'Medium time'
            ELSE 'Long time'
        END AS Duration
FROM    Exam;

-- Question 12. Thống kê số Account trong mỗi Group và in ra thêm 1 Column nữa có tên là `the_number_user_amount` và mang giá trị: few (nếu số lượng User trong Group =< 5), normal (nếu số lượng User trong Group <= 20 và > 5), higher (nếu số lượng User trong Group > 20)
SELECT      g.GroupName, COUNT(ga.AccountID) AS NUM_ACCOUNT,
            CASE
                WHEN    COUNT(ga.AccountID) <=5    THEN 'few'
                WHEN    COUNT(ga.AccountID) <=20   THEN 'normal'
                ELSE    'higher'
            END AS the_number_user_amount
FROM        GroupAccount    AS ga
RIGHT JOIN  `Group`         AS g    ON g.GroupID = ga.GroupID
GROUP BY    g.GroupName;

-- Question 13. Thống kê số User mỗi Phòng ban (Phòng ban không có User thì đổi 0 thành "Không có User")
SELECT      d.DepartmentName, 
            CASE
                WHEN COUNT(a.AccountID) = 0 THEN 'Không có User nào'
                ELSE COUNT(a.AccountID)
            END AS NUM_ACCOUNT
FROM        Account     AS a
RIGHT JOIN  Department  AS d    ON d.DepartmentID = a.DepartmentID
GROUP BY    d.DepartmentName;






