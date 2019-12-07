--1. Выведите содержимое таблицы сотрудников двумя способами(2 балла)
--a)
SELECT * FROM db_laba.dbo.employees
--b) 
SELECT 
       p.employee_id,
       p.first_name,
       p.last_name,
       p.email,
       p.phone,
       p.hire_date,
       p.manager_id,
       p.job_title 
FROM db_laba.dbo.employees as p

--2. Выведите имя, фамилию и номер телефона таблицы контактов где номер телефона начинается на +1 
--(примечание: для USA номер телефона начинается на +1) (3 балла)
SELECT 
      p.first_name,
      p.last_name,
      p.phone
FROM db_laba.dbo.contacts as p
WHERE p.phone LIKE '+1%'

--3. Выведите уникальный список идентификаторов продавцов используя таблицу заказов и колонку salesman_id. Не включать пустые идентификаторы. Отсортировать по возрастанию (3 балла)
SELECT  DISTINCT p.salesman_id
FROM db_laba.dbo.orders as p
WHERE p.salesman_id IS NOT NULL
ORDER BY p.salesman_id

/*
4. Выведите имя, фамилию, номер телефона и страну (новая колонка с именем country логика согласно номера телефона) из таблицы контактов

варианты колонки страны: USA или Other для вес других стран (примечание: необходимо использовать оператор CASE (для USA номер телефона начинается на +1) (3 балла)
Результат отсортируйте по колонке страны затем имени и фамилии
*/

SELECT 
      p.first_name,
      p.last_name,
      p.phone,
CASE 
 WHEN p.phone LIKE '+1%' THEN 'USA' 
 ELSE 'OTHER'
 END as country 
FROM db_laba.dbo.contacts as p
ORDER BY country,p.first_name,p.last_name

--5. Выведите имя продукта, описание и стандартную стоимость по продуктам со стандартной стоимостью НЕ в промежутке 500 до 4000 (включительно) (3 балла)
--Результат отсортировать по убыванию стандартной стоимости

SELECT 
    p.product_name,
    p.description,
    p.standard_cost
FROM db_laba.dbo.products p
WHERE p.standard_cost NOT BETWEEN 500 and 4000
ORDER BY p.standard_cost DESC

--6. Выведите имя продукта, описание и стандартную стоимость по продуктам со стандартной стоимостью в промежутке от 500 до 800 (включительно) для 3-й категории (3 балла)
--Результат отсортируйте по убыванию стандартной стоимости

SELECT 
    p.product_name,
    p.description,
    p.standard_cost
FROM db_laba.dbo.products p
WHERE p.standard_cost BETWEEN 500 and 800
AND p.category_id=3
ORDER BY p.standard_cost DESC

/*7. Выведите имя продукта, описание и стандартную стоимость по продуктам со стандартной стоимостью
для продуктов имена которых НЕ начинаются на букву K (буква латинского алфавита, не чувствителен регистру) 
кроме стоимости от 50 до 5000 (включительно)
для 1-й, 2-й, 3-й и 4-й категорий
Результат отсортируйте по стандартной стоимости (3 балла) */

SELECT 
    p.product_name,
    p.description,
    p.standard_cost
FROM db_laba.dbo.products p
WHERE p.product_name NOT LIKE 'K%'
AND p.standard_cost NOT BETWEEN 50 AND 5000
AND p.category_id BETWEEN 1 and 4
ORDER BY p.standard_cost
