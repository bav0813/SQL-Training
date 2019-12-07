/*1. Выведите все заказы для продавцов которые были наняты на работу в первом квартале 2016 года выведите колонки и отсортируйте 
на ваше усмотрение (4 балла)*/

SELECT 
* 
FROM db_laba.dbo.orders as o
WHERE o.salesman_id IN 
    (    
        SELECT
        p.employee_id
        FROM db_laba.dbo.employees as p
        WHERE p.hire_date BETWEEN  '2016-01-01' AND '2016-03-31' 
    ) 
ORDER BY o.salesman_id
    
/*2. Выведите номер и статус заказа, имя продавца и его телефон
для всех заказов, которые сделал самый лучший продавец 2016 года (продал больше всего товара в денежном эквиваленте)
Отсортируйте на ваше усмотрение (5 баллов)*/

SELECT ord2.order_id,ord2.status,emp.first_name,emp.phone
FROM db_laba.dbo.orders ord2 
JOIN db_laba.dbo.employees as emp
ON ord2.salesman_id=emp.employee_id
WHERE ord2.salesman_id=( 

            SELECT TOP 1 y.salesman_id
            FROM
            (
            SELECT ord.salesman_id, x.total
             FROM db_laba.dbo.orders AS ord
             JOIN 
                (
                    SELECT 
                    p.order_id,
                    SUM(p.unit_price*p.quantity) as total
                    FROM db_laba.dbo.order_items as p
                    GROUP BY p.order_id
                ) x
             ON ord.order_id=x.order_id
             WHERE ord.salesman_id IS NOT NULL
             AND ord.order_date BETWEEN '2016-01-01' AND '2016-12-31'
             ) y
              GROUP BY y.salesman_id
              ORDER BY SUM(y.total) DESC
          
          )
ORDER BY ord2.order_id

/*3. Выведите номер и статус заказа, имя продавца и его телефон

для всех заказов, которые сделал самый худший продавец 2015 года (продал меньше всего товара в количественном эквиваленте)

Отсортируйте на ваше усмотрение (5 баллов)*/

SELECT ord2.order_id,ord2.status,emp.first_name,emp.phone
FROM db_laba.dbo.orders ord2 
JOIN db_laba.dbo.employees as emp
ON ord2.salesman_id=emp.employee_id
WHERE ord2.salesman_id=( 

            SELECT TOP 1 y.salesman_id
            FROM
            (
            SELECT ord.salesman_id, SUM(x.total) as ttl 
             FROM db_laba.dbo.orders AS ord
             JOIN 
                (
                    SELECT 
                    p.order_id,
                    SUM(p.quantity) as total
                    FROM db_laba.dbo.order_items as p
                    GROUP BY p.order_id
                ) x
             ON ord.order_id=x.order_id
             WHERE ord.salesman_id IS NOT NULL
             AND ord.order_date BETWEEN '2015-01-01' AND '2015-12-31'
             GROUP BY ord.salesman_id
             ) y
              GROUP BY y.salesman_id
              ORDER BY SUM(y.ttl) 
          
          )
ORDER BY ord2.order_id

/*4. Выведите сумму маржи (подсказка: sum(quantity * list_price) - sum(quantity * standard_cost)), имя клиента и год заказа
Сгруппируйте по имени клиента и году заказа
для клиентов со средним количеством заказанных продуктов более чем среднее значение заказанных продуктов в 2016 году
Отсортируйте на ваше усмотрение (6 баллов)*/

SELECT cst.name, YEAR(x.order_date) as yr, (SUM(oi.quantity * prod.list_price) - SUM(oi.quantity * prod.standard_cost)) as margin 
FROM db_laba.dbo.order_items as oi 

JOIN  
    (
    SELECT ord.customer_id, AVG(oi.quantity) as avg, ord.order_id,ord.order_date
    FROM db_laba.dbo.orders as ord
    JOIN db_laba.dbo.order_items as oi ON ord.order_id=oi.order_id 
    GROUP BY ord.customer_id,ord.order_id,ord.order_date        
    HAVING AVG(oi.quantity) >
           (
            SELECT AVG(oi.quantity) as avg2016
            FROM db_laba.dbo.orders as ord
            JOIN db_laba.dbo.order_items as oi ON ord.order_id=oi.order_id 
            WHERE ord.order_date BETWEEN '2016-01-01' AND '2016-12-31' 
            ) 
    )        x    
    ON x.order_id=oi.order_id
 JOIN db_laba.dbo.products prod ON prod.product_id=x.order_id      
 JOIN db_laba.dbo.customers cst ON cst.customer_id=x.customer_id

 GROUP BY  cst.name, YEAR(x.order_date)
 ORDER BY cst.name
  
