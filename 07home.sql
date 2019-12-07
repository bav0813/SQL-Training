/*1. Вставьте строку со всеми колонками в таблицу employees_test_student используя перечисление колонок и их конкретные значение
напишите запрос для проверки
Примечание: используйте произвольные значение (4 балла)*/

INSERT
    INTO
    db_laba.dbo.employees_test_student
    (employee_id,
    first_name,
    last_name,
    email,
    phone,
    hire_date,
    manager_id,
    job_title,
    student_name)
VALUES(1308,
'Andriy',
'Bychkovsky',
'test@gmail.com',
'444-555-666',
CAST('2019-11-30' as date),
13,
'Supply Chain Manager',
'a.bychkovsky');

--Check
SELECT * from db_laba.dbo.employees_test_student t
where t.student_name = 'a.bychkovsky';

/*2. Выведите из таблицы employees все строки для должности Accountant и вставьте результат в таблицу employees_test_student
напишите запрос для проверки (4 балла)*/

select * from db_laba.dbo.employees_test_student 
INSERT INTO db_laba.dbo.employees_test_student 
    (
    employee_id,
    first_name,
    last_name,
    email,
    phone,
    hire_date,
    manager_id,
    job_title,
    student_name
    )
    SELECT *,'a.bychkovsky' from db_laba.dbo.employees emp
    where emp.job_title = 'Accountant';

--Check 
SELECT * from db_laba.dbo.employees_test_student t
where t.student_name = 'a.bychkovsky';

/*3. Поднимите в верхний регистр колонку employees_test_student.first_name
напишите запрос для проверки (4 балла)*/

update
    db_laba.dbo.employees_test_student 
set
    first_name = UPPER(first_name)
    --SELECT * from db_laba.dbo.employees_test_student
where student_name = 'a.bychkovsky'

--Check 
SELECT * from db_laba.dbo.employees_test_student t
where t.student_name = 'a.bychkovsky';

/*4. Обновите колонку employees_test_student.email таким образом, что бы остался только домен (пример: sample@cool.com => cool.com) для всех сотрудников длина фамилии которых до 5 символов включительно
напишите запрос для проверки (4 балла)*/

update
    db_laba.dbo.employees_test_student 
set
    email = RIGHT(email,LEN(email)-CHARINDEX('@',email))
    --SELECT * from db_laba.dbo.employees_test_student
where student_name = 'a.bychkovsky'

--Check 
SELECT * from db_laba.dbo.employees_test_student t
where t.student_name = 'a.bychkovsky';

/*5. Удалите строки из таблицы employees_test_student для сотрудников в телефоне которых цифра 2 встречается два раза
напишите запрос для проверки (4 балла)*/


DELETE from db_laba.dbo.employees_test_student 
where student_name = 'a.bychkovsky' AND
      LEN(phone)-LEN(REPLACE(phone,'2',''))=2
 
--Check 
SELECT * from db_laba.dbo.employees_test_student t
where t.student_name = 'a.bychkovsky';
