/*Задание 1: Анализ прибыли по категориям продуктов
Задание: Определите общую прибыль для каждой категории продуктов, 
используя таблицы OrderDetails, Orders и Products. Для расчета прибыли
умножьте цену продукта на количество, а затем суммируйте результаты по категориям.*/

/*select c.categoryname, sum(p.price * od.quantity) as total
from OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
join Categories с on c.CategoryID = p.CategoryID
join Products p on p.ProductID = od.ProductID
group by c.categoryname;*/

/*Задание 2: Количество заказов по регионам Задание:
Определите количество заказов, размещенных клиентами из различных стран, за каждый месяц.
*/
/*SELECT
    c.Country AS Country,
    MONTH(o.OrderDate) AS Month,
    YEAR(o.OrderDate) AS Year,
    COUNT(o.OrderID) AS OrderCount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country, MONTH(o.OrderDate), YEAR(o.OrderDate);*/

/*Задание 3: Средняя продолжительность кредитного срока для клиентов
Задание: Рассчитайте среднюю продолжительность кредитного срока для клиентов по категориям образования.*/

select DISTINCT education, avg(credit_term) as average_term from Clusters2
group by education











    
    