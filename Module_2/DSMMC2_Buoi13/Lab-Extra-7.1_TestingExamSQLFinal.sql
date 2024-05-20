-- 1. Tạo bảng với ràng buộc và kiểu dữ liệu. Sau đó, thêm ít nhất 5 bản ghi vào bảng.
-- Tạo database Testing_System_Db;
DROP DATABASE IF EXISTS Testing_Exam_SQL;
CREATE DATABASE Testing_Exam_SQL;
USE Testing_Exam_SQL;

-- Tạo table CUSTOMER
DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255),
    Note TEXT
);

-- Tạo table CAR
DROP TABLE IF EXISTS CAR;
CREATE TABLE CAR (
    CarID INT PRIMARY KEY,
    Maker ENUM('HONDA', 'TOYOTA', 'NISSAN'),
    Model VARCHAR(100),
    Year INT,
    Color VARCHAR(50),
    Note TEXT
);

-- Tạo table CAR_ORDER
DROP TABLE IF EXISTS CAR_ORDER;
CREATE TABLE CAR_ORDER (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CarID INT,
    Amount INT DEFAULT 1,
    SalePrice DECIMAL(10, 2),
    OrderDate DATE,
    DeliveryDate DATE,
    DeliveryAddress VARCHAR(255),
    Status TINYINT DEFAULT 0,
    Note TEXT,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (CarID) REFERENCES CAR(CarID)
);

-- Thêm ít nhất 5 bản ghi vào bảng CUSTOMER
INSERT INTO CUSTOMER (Name, Phone, Email, Address, Note) VALUES
('Nguyen Van A', '0901234567', 'nguyenvana@example.com', '123 Nguyen Trai, Hanoi', 'VIP customer'),
('Le Thi B', '0912345678', 'lethib@example.com', '456 Le Loi, HCMC', ''),
('Tran Van C', '0923456789', 'tranvanc@example.com', '789 Tran Hung Dao, Danang', 'Frequent buyer'),
('Pham Thi D', '0934567890', 'phamthid@example.com', '101 Hai Ba Trung, Hue', 'New customer'),
('Hoang Van E', '0945678901', 'hoangvane@example.com', '202 Vo Thi Sau, Can Tho', 'Priority customer');

-- Thêm ít nhất 5 bản ghi vào bảng CAR
INSERT INTO CAR (CarID, Maker, Model, Year, Color, Note) VALUES
(1, 'HONDA', 'Civic', 2020, 'black', 'Popular model'),
(2, 'TOYOTA', 'Corolla', 2021, 'white', ''),
(3, 'NISSAN', 'Altima', 2019, 'blue', 'Award-winning car'),
(4, 'HONDA', 'Accord', 2022, 'silver', ''),
(5, 'TOYOTA', 'Camry', 2020, 'red', 'High demand');

-- Thêm ít nhất 5 bản ghi vào bảng CAR_ORDER
INSERT INTO CAR_ORDER (CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, Status, Note) VALUES
(1, 5, 4, 25000.00, '2024-01-15', '2024-02-01', '123 Nguyen Trai, Hanoi', 1, 'Delivered on time'),
(2, 1, 2, 30000.00, '2024-01-20', '2024-02-10', '456 Le Loi, HCMC', 1, ''),
(3, 4, 5, 27000.00, '2024-01-25', '2024-02-15', '789 Tran Hung Dao, Danang', 1, 'Delivered early'),
(4, 2, 3, 40000.00, '2024-01-30', '2024-02-20', '101 Hai Ba Trung, Hue', 0, 'Pending'),
(5, 3, 1, 32000.00, '2024-02-05', '2024-02-25', '202 Vo Thi Sau, Can Tho', 0, 'Pending');

-- 2. Lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã mua và sắp xếp tăng dần theo số lượng oto đã mua.
SELECT c.Name, SUM(co.Amount) AS TotalCarsBought
FROM CUSTOMER c
JOIN CAR_ORDER co ON c.CustomerID = co.CustomerID
GROUP BY c.Name
ORDER BY TotalCarsBought ASC;

-- 3. Hàm (không có parameter) trả về tên hãng sản xuất đã bán được nhiều oto nhất trong năm nay.
DELIMITER $$
CREATE FUNCTION MostSoldMakerThisYear() 
RETURNS VARCHAR(50)
READS SQL DATA
BEGIN
    DECLARE maker VARCHAR(50);
    SELECT c.Maker INTO maker
    FROM CAR c
    JOIN CAR_ORDER co ON c.CarID = co.CarID
    WHERE YEAR(co.OrderDate) = YEAR(CURDATE())
    GROUP BY c.Maker
    ORDER BY SUM(co.Amount) DESC
    LIMIT 1;
    RETURN maker;
END$$
DELIMITER ;

-- 4. Thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của những năm trước và in ra số lượng bản ghi đã bị xóa.
DELIMITER $$
CREATE PROCEDURE DeleteCancelledOrders()
BEGIN
    DECLARE deletedCount INT DEFAULT 0;
    DELETE FROM CAR_ORDER
    WHERE Status = 2 AND YEAR(OrderDate) < YEAR(CURDATE());
    SET deletedCount = ROW_COUNT();
    SELECT CONCAT(deletedCount, ' records have been deleted.') AS Result;
END$$
DELIMITER ;

-- 5. Thủ tục (có CustomerID parameter) để in ra thông tin của các đơn hàng đã đặt hàng.
DELIMITER $$
CREATE PROCEDURE CustomerOrdersInfo(IN CustID INT)
BEGIN
    SELECT c.Name, co.OrderID, co.Amount, ca.Maker
    FROM CUSTOMER c
    JOIN CAR_ORDER co ON c.CustomerID = co.CustomerID
    JOIN CAR ca ON co.CarID = ca.CarID
    WHERE c.CustomerID = CustID AND co.Status = 0;
END$$
DELIMITER ;

-- 6. Trigger để tránh trường hợp người dùng nhập thông tin không hợp lệ vào database (DeliveryDate < OrderDate + 15)
DELIMITER $$
CREATE TRIGGER ValidateDeliveryDate
BEFORE INSERT ON CAR_ORDER
FOR EACH ROW
BEGIN
    IF NEW.DeliveryDate < NEW.OrderDate + INTERVAL 15 DAY THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'DeliveryDate must be at least 15 days after OrderDate.';
    END IF;
END$$
DELIMITER ;
