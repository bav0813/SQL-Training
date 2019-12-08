/*1. Создайте таблицу с именем invoices_<name> (придумайте перечень колонок самостоятельно) 
Таблица должна содержать все необходимые ограничения и первичные ключи. (5 баллов)*/

--DROP TABLE db_laba.dbo.invoices_abychkovsky

CREATE TABLE db_laba.dbo.invoices_abychkovsky
( id int PRIMARY KEY NOT NULL, 
  total money,
  status varchar(20),
  inv_date date
 )

 INSERT INTO db_laba.dbo.invoices_abychkovsky
 (
 id,total,status,inv_date
 )
 VALUES
 (1,102.1, 'shipped','2019-12-01'),
( 2,2.1, 'pending','2019-12-02')

/*2. Создайте таблицу с именем invoices_details_<name> (придумайте перечень колонок самостоятельно) 
Таблица должна содержать все необходимые ограничения и связь с таблицей invoices_<name>.
Продемонстрируйте тестовыми изменениями целостность данных (5 баллов)*/

--DROP TABLE db_laba.dbo.invoices_details_abychkovsky
CREATE TABLE db_laba.dbo.invoices_details_abychkovsky
( id int PRIMARY KEY, 
  invoice_id int,
  customer_id int,
  ref_no int
  CONSTRAINT fk_invoices_details_invoices_abychkovsky FOREIGN KEY(invoice_id)
  REFERENCES db_laba.dbo.invoices_abychkovsky(id) ON DELETE CASCADE
)

SELECT * FROM db_laba.dbo.invoices_abychkovsky

 INSERT INTO db_laba.dbo.invoices_details_abychkovsky
 (
 id,invoice_id,customer_id,ref_no
 )
 VALUES
(1,1,10,222),
( 2,2,5,555)
--( 3,2,5,555)  --error: The INSERT statement conflicted with the FOREIGN KEY constraint "fk_invoices_details_invoices_abychkovsky

SELECT * FROM db_laba.dbo.invoices_details_abychkovsky
--check cascade delete
DELETE FROM db_laba.dbo.invoices_abychkovsky
WHERE id=2
--check
SELECT * FROM db_laba.dbo.invoices_details_abychkovsky

/*3. Используя наши старые таблицы для обучения (не нужно использовать таблицы из пунктов 1 и 2), 
создайте представление которое будет содержать 
количество заказов, год продажи, имя и фамилию продавца
имя созданного представления должно отображать содержимое (5 баллов)*/

--DROP VIEW  IF EXISTS dbo.salesman_stats_abychkovsky
CREATE VIEW dbo.salesman_stats_abychkovsky
AS
SELECT COUNT(o.order_id) as ttl,YEAR(o.order_date) as yr,emp.first_name,emp.last_name
FROM db_laba.dbo.orders o
LEFT JOIN db_laba.dbo.employees emp ON emp.employee_id=o.salesman_id
GROUP BY YEAR(o.order_date),emp.first_name,emp.last_name

SELECT * FROM dbo.salesman_stats_abychkovsky

--DROP VIEW  IF EXISTS dbo.salesman_stats;  

/*4. Измените представление из пункта 3, 
добавьте в вывод имя, фамилию и телефон менеджера для продавца (5 баллов)*/

ALTER VIEW dbo.salesman_stats_abychkovsky
AS
SELECT COUNT(o.order_id) as ttl,YEAR(o.order_date) as yr,emp.first_name,emp.last_name,
mng.first_name mng_name,mng.last_name mng_last_name,mng.phone mng_phone
FROM db_laba.dbo.orders o
--JOIN db_laba.dbo.orders o ON o.order_id=oi.order_id 
LEFT JOIN db_laba.dbo.employees emp ON emp.employee_id=o.salesman_id
LEFT JOIN db_laba.dbo.employees mng ON mng.employee_id=emp.manager_id
GROUP BY YEAR(o.order_date),
emp.first_name,emp.last_name,
mng.first_name,mng.last_name,mng.phone

SELECT * FROM dbo.salesman_stats_abychkovsky
