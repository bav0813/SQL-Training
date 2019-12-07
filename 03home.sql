--1. Выведите общую сумму, среднюю сумму, минимальную сумму, максимальную сумму и количество позиций для заказов (таблица order_items колонки unit_price * quantity) 

--для товаров продаваемых более 100 единиц (подсказка WHERE, все агрегаты должны быть в одном запросе) (2 балла)

SELECT
    SUM(p.unit_price*p.quantity) as total_sum,
    AVG(p.unit_price*p.quantity) as avg_sum,
    MIN(p.unit_price*p.quantity) as min_sum,
    MAX(p.unit_price*p.quantity) as max_sum,
    COUNT(*)
FROM
    db_laba.dbo.order_items as p
WHERE p.quantity>100

/*2. Выведите общую сумму, среднюю сумму, минимальную сумму, максимальную сумму и количество позиций  для заказов 
(таблица order_items колонки unit_price * quantity)
для товаров продаваемых в среднем более 100 единиц  (подсказка HAVING все агрегаты должны быть в одном запросе) (3 балла)
*/

SELECT
    SUM(p.unit_price*p.quantity) as total_sum,
    AVG(p.unit_price*p.quantity) as avg_sum,
    MIN(p.unit_price*p.quantity) as min_sum,
    MAX(p.unit_price*p.quantity) as max_sum,
    COUNT(*)
FROM
    db_laba.dbo.order_items as p
HAVING AVG(p.quantity)>100

--3. Выведите максимальное и минимальное значение цены для каждой категории (таблица products) 
--для товаров цена на сайте которых в промежутке 200 - 750 (включительно) (3 балла)

SELECT
    MIN(p.standard_cost) as min_cost,
    MAX(p.standard_cost) as max_cost
FROM
    db_laba.dbo.products as p
WHERE p.standard_cost BETWEEN 200 AND 750
GROUP BY p.category_id

--4. Выведите количество сотрудников и количество должностей в компании (таблица employees) (3 балла)
SELECT 
    COUNT(p.employee_id) as employees_cnt,
    COUNT(DISTINCT(p.job_title)) as jobs_cnt
FROM
    db_laba.dbo.employees as p

/*5. Выведите суммы продаж в разрезе идентификатора продукта (таблица order_items) 
для продуктов со средней продажей не менее 500 шт (не включительно)
Отсортируйте по убыванию сумме продаж (3 балла)*/

SELECT 
    SUM(p.quantity*p.unit_price) as sales_sum
FROM
    db_laba.dbo.order_items as p
HAVING AVG(p.quantity)>500
ORDER BY sales_sum DESC

/*6. Выведите номера заказов и количество позиций в чеке (таблица order_items) 
для заказов на сумму свыше 1000 (включительно) и средней суммой не выше 2000 (включительно)
Отсортируйте по номеру заказа (3 балла)*/

SELECT 
    p.order_id,
    COUNT(p.quantity) as qnt
FROM
    db_laba.dbo.order_items as p
GROUP BY p.order_id
HAVING AVG(p.quantity*p.unit_price)<=2000 AND (SUM(p.quantity*p.unit_price)>=1000)
ORDER BY p.order_id


/*7. Выведите количество заказов, идентификатор продавца и год продажи используя функцию YEAR, (таблица orders)
для заказов в статусе 'Отправлено' или 'В ожидании' (примечание: 'Shipped', 'Pending')
Отсортируйте по году по возрастанию, затем количество заказов по убыванию, затем идентификатор продавца по возрастанию. (3 балла)*/

SELECT
COUNT(p.order_id) as orders_qty,
p.salesman_id,
YEAR(p.order_date) as year_
FROM
    db_laba.dbo.orders as p
WHERE p.status IN ('Shipped','Pending')
GROUP BY YEAR(p.order_date),p.salesman_id
ORDER BY year_, orders_qty DESC, p.salesman_id 
