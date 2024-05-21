USE Testing_System_Db;

-- Question 1: 
DELIMITER //

CREATE PROCEDURE GetAccountsByDepartment(IN department_name VARCHAR(255))
BEGIN
    SELECT * 
    FROM Account 
    WHERE DepartmentID = (SELECT DepartmentID 
						  FROM Department 
                          WHERE DepartmentName = department_name);
END //

DELIMITER ;

-- Question 2: 
DELIMITER //

CREATE PROCEDURE CountAccountsPerGroup()
BEGIN
    SELECT GroupID, COUNT(*) AS NumAccounts 
    FROM GroupAccount
    GROUP BY GroupID;
END //

DELIMITER ;

-- Question 3: 
DELIMITER //

CREATE PROCEDURE CountQuestionsPerTypeInCurrentMonth()
BEGIN
    DECLARE current_month INT;
    SET current_month = MONTH(CURRENT_DATE());
    SELECT TypeID, COUNT(*) AS NumQuestions
    FROM Question
    WHERE MONTH(CreateDate) = current_month
    GROUP BY TypeID;
END //

DELIMITER ;

-- Question 4: 
DELIMITER //

CREATE PROCEDURE GetMostCommonQuestionType()
BEGIN
    SELECT TypeID
    FROM (
        SELECT TypeID, COUNT(*) AS NumQuestions
        FROM Question
        GROUP BY TypeID
        ORDER BY NumQuestions DESC
        LIMIT 1
    ) AS MostCommonType;
END //

DELIMITER ;

-- Question 5:
DELIMITER //

CREATE PROCEDURE GetMostCommonQuestionTypeName()
BEGIN
    DECLARE most_common_type_id INT;
    SELECT GetMostCommonQuestionType() INTO most_common_type_id;
    SELECT TypeName FROM TypeQuestion WHERE TypeID = most_common_type_id;
END //

DELIMITER ;

-- Question 6:
DELIMITER //

CREATE PROCEDURE SearchGroupOrUser(IN search_string VARCHAR(255))
BEGIN
    SELECT * FROM `Group` WHERE GroupName LIKE CONCAT('%', search_string, '%')
    UNION
    SELECT * FROM Account WHERE Username LIKE CONCAT('%', search_string, '%');
END //

DELIMITER ;

-- Question 7:
DELIMITER //

CREATE PROCEDURE CreateAccount(
    IN full_name VARCHAR(255),
    IN email VARCHAR(255)
)
BEGIN
    DECLARE username VARCHAR(255);
    DECLARE position_id INT DEFAULT 1; -- Developer
    DECLARE department_id INT DEFAULT 1; -- Default department
    SET username = SUBSTRING_INDEX(email, '@', 1);
    INSERT INTO Account (Email, Username, FullName, DepartmentID, PositionID, CreateDate)
    VALUES (email, username, full_name, department_id, position_id, CURRENT_DATE());
    SELECT CONCAT('Account created successfully for ', full_name);
END //

DELIMITER ;

-- Question 8:
DELIMITER //

CREATE PROCEDURE LongestContentQuestion(IN question_type VARCHAR(255))
BEGIN
    DECLARE question_id INT;
    SELECT QuestionID INTO question_id
    FROM Question
    WHERE TypeID = (SELECT TypeID FROM TypeQuestion WHERE TypeName = question_type)
    ORDER BY LENGTH(Content) DESC
    LIMIT 1;
    SELECT * FROM Question WHERE QuestionID = question_id;
END //

DELIMITER ;

-- Question 9: 
DELIMITER //

CREATE PROCEDURE DeleteExamByID(IN exam_id INT)
BEGIN
    DELETE FROM Exam WHERE ExamID = exam_id;
    SELECT CONCAT('Exam with ID ', exam_id, ' deleted successfully');
END //

DELIMITER ;

-- Question 10:
DELIMITER //

CREATE PROCEDURE DeleteOldExams()
BEGIN
    DECLARE removed_records INT DEFAULT 0;
    DECLARE old_exam_id INT;
    DECLARE cur CURSOR FOR SELECT ExamID FROM Exam WHERE CreateDate < DATE_SUB(NOW(), INTERVAL 3 YEAR);
    OPEN cur;
    FETCH cur INTO old_exam_id;
    WHILE old_exam_id IS NOT NULL DO
        CALL DeleteExamByID(old_exam_id);
        SET removed_records = removed_records + ROW_COUNT();
        FETCH cur INTO old_exam_id;
    END WHILE;
    CLOSE cur;
    SELECT CONCAT(removed_records, ' records removed');
END //

DELIMITER ;

-- Question 11:
DELIMITER //

CREATE PROCEDURE MoveAccountsToDefaultDepartment(IN department_name VARCHAR(255))
BEGIN
    DECLARE default_department_id INT;
    SET default_department_id = (SELECT DepartmentID 
								 FROM Department 
                                 WHERE DepartmentName = 'Phòng chờ việc');
    UPDATE Account 
    SET DepartmentID = default_department_id 
    WHERE DepartmentID = (SELECT DepartmentID 
						  FROM Department
                          WHERE DepartmentName = department_name);
END //

DELIMITER ;

-- Question 12:
DELIMITER //

CREATE PROCEDURE CountQuestionsPerMonthInCurrentYear()
BEGIN
    SELECT MONTH(CreateDate) AS Month, COUNT(*) AS NumQuestions
    FROM Question
    WHERE YEAR(CreateDate) = YEAR(CURRENT_DATE())
    GROUP BY MONTH(CreateDate);
END //

DELIMITER ;

-- Question 13:
DELIMITER //

CREATE PROCEDURE CountQuestionsPerLastSixMonths()
BEGIN
    DECLARE start_month INT;
    DECLARE current_month INT;
    SET current_month = MONTH(CURRENT_DATE());
    SET start_month = current_month - 5;
    IF start_month <= 0 THEN
        SET start_month = 12 + start_month;
    END IF;
    CREATE TEMPORARY TABLE IF NOT EXISTS MonthQuestionCount (
        Month INT,
        NumQuestions INT
    );
    TRUNCATE TABLE MonthQuestionCount;
    WHILE start_month != current_month DO
        INSERT INTO MonthQuestionCount (Month, NumQuestions)
        SELECT start_month AS Month, COUNT(*) AS NumQuestions
        FROM Question
        WHERE YEAR(CreateDate) = YEAR(CURRENT_DATE()) AND MONTH(CreateDate) = start_month;
        SET start_month = start_month + 1;
        IF start_month > 12 THEN
            SET start_month = 1;
        END IF;
    END WHILE;
    INSERT INTO MonthQuestionCount (Month, NumQuestions)
    SELECT current_month AS Month, COUNT(*) AS NumQuestions
    FROM Question
    WHERE YEAR(CreateDate) = YEAR(CURRENT_DATE()) AND MONTH(CreateDate) = current_month;
    SELECT * FROM MonthQuestionCount;
    DROP TABLE IF EXISTS MonthQuestionCount;
END //

DELIMITER ;


