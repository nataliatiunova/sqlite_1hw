/*Описание: Вам необходимо проверить, как различные категории продуктов влияют на общий доход (общую сумму заказов) в таблице OrderDetails. Подсчитайте общее
количество заказов (сумму количества) и общий доход (сумму количества * цену) для каждой категории продуктов. Выведите результаты, включая:
● CategoryID
● Общее количество заказов (total_quantity)
● Общий доход (total_revenue)
Отсортируйте результаты по убыванию общего дохода (total_revenue). Используйте таблицы Products, OrderDetails и Categories.

SELECT
    p.CategoryID,
    SUM(od.Quantity) AS total_quantity,
    SUM(od.Quantity * p.Price) AS total_revenue
FROM
    OrderDetails od
JOIN
    Products as p ON od.ProductID = p.ProductID
GROUP BY
    p.CategoryID
ORDER BY
    total_revenue DESC;*/
    
/*Задание No2: Анализ частоты заказа продуктов по категориям
Описание: Напишите запрос SQL для подсчета количества заказов продуктов по каждой категории. Подсчитайте количество уникальных заказов (OrderID) для каждой категории продуктов. Выведите результаты, включая:
● CategoryID
● Количество уникальных заказов (order_count)
Отсортируйте результаты по убыванию количества уникальных заказов (order_count). Используйте таблицы Products, OrderDetails и Categories.Clusters


SELECT
	p.categoryid,
    count(DISTINCT od.OrderID) as order_count
    from OrderDetails od
join
Products as p on od.ProductID = p.ProductID
GROUP BY
    p.CategoryID
order by order_count desc;
*/

/*Задание No3: Вывод наиболее популярных продуктов по количеству заказов
Описание: Выведите список продуктов (название ProductName), отсортированных по количеству заказов в порядке убывания. Подсчитайте общее количество заказов (Quantity) для каждого продукта. Выведите результаты, включая:
● ProductName
● Общее количество заказов (total_quantity)
 
Отсортируйте результаты по убыванию общего количества заказов (total_quantity). Используйте таблицы Products и OrderDetails.
*/

SELECT
	p.productname,
    sum(od.orderid) as total_quantity
    from OrderDetails od
join
Products as p on od.ProductID=p.ProductID
group BY
productname
order by total_quantity desc;