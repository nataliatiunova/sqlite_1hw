/*Задание 1: Ранжирование продуктов по средней цене
Задание: Ранжируйте продукты в каждой категории на основе их средней цены
(AvgPrice). 
Используйте таблицы OrderDetails и Products. Результат: В результате запроса будут следующие столбцы:
● CategoryID:идентификаторкатегориипродукта, 
● ProductID:идентификаторпродукта,
● ProductName:названиепродукта,
● AvgPrice:средняяценапродукта,
● ProductRank:рангпродуктавнутрисвоейкатегориинаосновесреднейценыв порядке убывания.*/
WITH ProductAvgPrice AS (
SELECT p.productname, p.productid, p.categoryid, AVG(p.price) as AvgPrice
from Products2 p
join OrderDetails2 od on p.ProductID = od.ProductID
group by p.CategoryID, p.ProductID, p.ProductName)

SELECT categoryid, productid, productname, AvgPrice,
RANK() OVER (Partition BY CategoryID ORDER BY AvgPrice DESC) AS ProductRank
FROM ProductAvgPrice;


/*Задание 2: Средняя и максимальная сумма кредита по месяцам
Задание: Рассчитайте среднюю сумму кредита (AvgCreditAmount) для каждого кластера в
каждом месяце и сравните её с максимальной суммой кредита (MaxCreditAmount) за тот же месяц. 
Используйте таблицу Clusters.*/

-- Рассчитываем среднюю сумму кредита для каждого кластера и месяца
with AvgCredit as (
select month, cluster, AVG(credit_amount) as AvgCreditAmount from Clusters2
group by month, cluster),
MaxCredit as (
SELECT
month, MAX(credit_amount) as MaxCreditAmount
from Clusters2
group by month)
SELECT
    a.month,
    a.cluster,
    a.AvgCreditAmount,
    m.MaxCreditAmount
FROM AvgCredit a
JOIN MaxCredit m ON a.month = m.month;

/*Задание 3: Разница в суммах кредита по месяцам
Задание: Создайте таблицу с разницей (Difference) между суммой кредита и предыдущей суммой кредита
по месяцам для каждого кластера. Используйте таблицу Clusters*/

-- Рассчитываем сумму кредита и сумму кредита в предыдущем месяце
WITH CreditWithPrevious AS (
SELECT month,cluster,credit_amount,
--Функция LAG() используется для получения значения предыдущей строки в рамках окна
LAG(credit_amount) OVER (PARTITION BY cluster ORDER BY month) AS PreviousCreditAmount
FROM Clusters2
)
-- Вычисляем разницу между текущей и предыдущей суммой кредита
SELECT
    month,
    cluster,
    credit_amount,
    PreviousCreditAmount,
    COALESCE(credit_amount - PreviousCreditAmount, 0) AS Difference
-- COALESCE() для обработки возможных значений NULL
FROM CreditWithPrevious;