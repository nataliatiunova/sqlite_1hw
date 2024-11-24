/*
Задание 1: Создание таблицы и изменение данных
Задание: Создайте таблицу EmployeeDetails для хранения информации о
сотрудниках. Таблица должна содержать следующие столбцы:
● EmployeeID(INTEGER,PRIMARYKEY) 
● EmployeeName(TEXT)
● Position(TEXT)
● HireDate(DATE)
● Salary(NUMERIC)
После создания таблицы добавьте в неё три записи с произвольными данными о
сотрудниках.
*/
--создание таблицы EmployeeDetails
CREATE TABLE EmployeeDetails (
  EmployeeID INT PRIMARY KEY,
  EmployeeName VARCHAR(15),
  Position VARCHAR(15),
  HireDate DATE,
  Salary NUMERIC(8,2)
  );
  
-- вставка данных в EmployeeDetails
INSERT INTO EmployeeDetails (employeeid, employeename, position, hiredate, salary)
VALUES
	(1, 'Boris Ivanov', 'senior developer', '2024-01-01', 100000.00);
    
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary)
VALUES 
  (2, 'Alexander Petrov', 'developer', '2024-03-01', 80000.00),
  (3, 'Vasiliy Sidorov', 'intern', '2024-05-01', 50000.00);

-- вывод данных EmployeeDetails
SELECT * from EmployeeDetails


/*
Задание 2: Создание представления
Задание: Создайте представление HighValueOrders для отображения всех заказов,
сумма которых превышает 10000. В представлении должны быть следующие столбцы:
● OrderID(идентификаторзаказа),
● OrderDate(датазаказа),
● TotalAmount(общаясуммазаказа,вычисленнаякаксуммавсехQuantity*
Price).
Используйте таблицы Orders, OrderDetails и Products.
*/
--удаление таблицы HighValueOrders, если такая существует
DROP VIEW IF EXISTS HighValueOrders;

--создание представления HighValueOrders
CREATE VIEW HighValueOrders AS
SELECT 
o.OrderID, o.OrderDate, SUM(p.price * od.quantity) as TotalAmount
from Orders o
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
group by o.orderid, o.orderdate
HAVING SUM(p.price * od.quantity) > 10000;

--вывод представления HighValueOrders
select *
from HighValueOrders;

--проверка наличия заказов с суммой 10000
SELECT MAX(p.Price * od.Quantity) AS MaxOrderAmount
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID;

/*
Задание 3: Удаление данных и таблиц
Задание: Удалите все записи из таблицы EmployeeDetails, где Salary меньше
80000. Затем удалите таблицу EmployeeDetails из базы данных.
*/
--удаление строк с зарплатой < 80000
SELECT salary from EmployeeDetails
DELETE from EmployeeDetails
where salary < 80000;

--вывод таблицы
SELECT * from EmployeeDetails;

--удаление таблицы
drop TABLE if exists EmployeeDetails;

/*
Задание 4: Создание хранимой процедуры
Задание: Создайте хранимую процедуру GetProductSales с одним параметром ProductID.
Эта процедура должна возвращать список всех заказов, в которых участвует продукт с заданным ProductID,
включая следующие столбцы:
● OrderID(идентификаторзаказа),
● OrderDate(датазаказа),
● CustomerID(идентификаторклиента).OrderDetails
*/
DELIMITER //

CREATE Procedure GetProductSales (in productid_param INT)
BEGIN
SELECT 
o.orderid, o.orderdate, o.customerid
from Orders o
join OrderDetails od on o.OrderID = od.OrderID
where od.productid = productid_param;
end;
//

DELIMITER ;

--вызов процедуры 
CALL GetProductSales();



