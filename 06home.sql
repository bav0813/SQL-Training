/*1. Выведите все детали заказа и процент количества проданных продуктов от общего заказа для заказов 2016 года (5 баллов)*/ 

select
        o.order_id,
        o.item_id,
        o0.order_date,
        o.unit_price,
        o.quantity,
        SUM(o.quantity)
                OVER(PARTITION BY o.order_id ORDER BY o.quantity desc) AS Total ,
            CAST(o.quantity /
             SUM(o.quantity) OVER(PARTITION BY o.order_id) * 100 AS DECIMAL(5,2)) AS share_per_order
    from
        db_laba.dbo.order_items o
    inner join db_laba.dbo.orders o0 on
        o.order_id = o0.order_id
        AND o0.order_date BETWEEN '2016-01-01' AND '2016-12-31'
        
        /*2. Выведите топ 5 четных продавцов (примечание: 2, 4, 6, 8 и 10) по 
количеству проданных продуктов продаж за все время,
  *  но только четные места (5 баллов)*/


SELECT TOP 5 * FROM
     (
     SELECT ord.salesman_id,SUM(oi.quantity) as ttl,
     ROW_NUMBER() OVER (ORDER BY SUM(oi.quantity) DESC) AS Row_num
     FROM db_laba.dbo.order_items oi
     JOIN db_laba.dbo.orders ord on ord.order_id=oi.order_id
     WHERE ord.salesman_id IS NOT NULL
     GROUP BY ord.salesman_id
     ) x
WHERE x.Row_num%2=0

/*3. Выведите id заказчика, дату заказа, id заказа и стоимость заказа, а 
так же стоимость предыдущего заказа
  со смещением в 3 строки (подсказка: LAG с аргументом) (5 баллов) */


SELECT *,
LAG(x.ttl,3) OVER (PARTITION BY x.customer_id ORDER BY 
x.customer_id,x.order_date,x.order_date) prev
FROM
    (
     SELECT ord.customer_id, ord.order_date, ord.order_id,
     SUM(oi.quantity*oi.unit_price) OVER (PARTITION BY ord.order_id) as ttl
     FROM db_laba.dbo.orders ord
     JOIN db_laba.dbo.order_items oi ON oi.order_id=ord.order_id
    ) x


/*4. Сформулируйте требования для запроса: */

/*Выведите все детали заказа, стоимость всего заказа, изменение стоимости относительно первого и последнего заказа покупателя */

SELECT

o.customer_id,
o.order_date,
o.order_id,
o2.price,
o2.price - FIRST_VALUE(o2.price)
OVER(PARTITION BY o.customer_id ORDER BY o.order_date, o.order_id) AS 
val_firstorder,

o2.price - LAST_VALUE(o2.price)
OVER(PARTITION BY o.customer_id ORDER BY o.order_date, o.order_id ROWS 
BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS val_lastorder

FROM

db_laba.dbo.orders o
inner join (
             select
             sum(oi.unit_price * oi.quantity) price,
             oi.order_id
             from
             db_laba.dbo.order_items oi
             group by
             oi.order_id) o2
             on
             o.order_id = o2.order_id
 
