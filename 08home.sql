/*1. Создайте таблицу для хранения списка книг в библиотеке (пример имени таблицы books_mbelko).
без первичных ключей и ограничений
перечень и имена колонок на Ваше усмотрение вставьте 3 произвольные строки с данными для всех колонок напишите 
проверочный скрипт демонстрирующий Ваше изменения используя словарь INFORMATION_SCHEMA.COLUMNS напишите 
проверочный скрипт на содержание вашего инсерта (5 баллов)*/


--DROP TABLE db_laba.dbo.books_abychkovsky CREATE TABLE db_laba.dbo.books_abychkovsky ( id int, author varchar(255), title varchar(255), publisher varchar(255), published_at date)

INSERT INTO db_laba.dbo.books_abychkovsky 
( id, author, title, publisher,published_at)
VALUES
(
1,
'J.Rouling',
'Harry Potter',
'Pottermore limited',
'2019-12-12'),
(
2,
'S.King',
'Green Mile',
'ACT',
'2018-02-15'),
(
3,
'J.Talkien',
'The Lord of the Rings',
'ACT',
'2016-12-01')

--check
SELECT
ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME='books_abychkovsky'

SELECT * FROM db_laba.dbo.books_abychkovsky

/*2. В созданную в первом задании таблицу добавьте колонку description с типом данных char(32) вставьте 3 
произвольные строки с данными для всех колонок напишите проверочный скрипт демонстрирующий Ваше 
изменения используя словарь INFORMATION_SCHEMA.COLUMNS напишите проверочный скрипт на содержание вашего инсерта (5 баллов) */

alter table db_laba.dbo.books_abychkovsky add description char(32); 
INSERT INTO db_laba.dbo.books_abychkovsky 
( id, author, title, publisher, published_at, description)
VALUES
(
4,
'L.Tolstoy',
'War and Peace',
'Tolstoy limited',
'2019-12-25',
'classics'),
(
5,
'E.Merphy',
'Financy',
'BCT',
'2015-02-15',
'about finance'),
(
6,
'H.Lee',
'To kill a mockenbird',
'LLL',
'2016-12-01',
'famous one')

--check
SELECT
ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME='books_abychkovsky'

SELECT * FROM db_laba.dbo.books_abychkovsky

/*3. В созданную в первом задании таблицу вставить строку с произвольными данными, но для в колонки description
  * вставить следующий текст:
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
(подсказка для этого Вам понадобиться изменить тип данных колонки description)
напишите все использованные скрипты для модификации таблицы напишите проверочный скрипт демонстрирующий Ваше изменения 
используя словарь INFORMATION_SCHEMA.COLUMNS напишите проверочный скрипт на содержание вашего инсерта (5 баллов)*/

alter table db_laba.dbo.books_abychkovsky alter column description varchar(255); 
INSERT INTO db_laba.dbo.books_abychkovsky 
( 
id, 
author, 
title, 
publisher, 
published_at,
description
)
VALUES
(
7,
'D.Sklar',
'PHP Cookbook',
'O`Reily',
'2019-12-25',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')

SELECT
ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME='books_abychkovsky'

SELECT * FROM db_laba.dbo.books_abychkovsky

/*4. Создайте новую таблицу на основе таблицы из первого задания (со всеми колонками и 7ю строками на текущий момент) 
сделайте колонку description обязательной ко вводу и длиной не менее 3 символов со значением по умолчанию N/A напишите 
все использованные скрипты для модификации таблицы напишите проверочный скрипт демонстрирующий Ваше изменения используя 
словарь INFORMATION_SCHEMA.COLUMNS напишите проверочный скрипт на содержание вашей новой таблицы (5 баллов)*/

 

CREATE TABLE db_laba.dbo.books_abychkovsky2 
( id int, 
author varchar(255), 
title varchar(255), 
publisher varchar(255), 
published_at date, 
description varchar(255) CHECK (LEN(description)>=3) DEFAULT 'N/A' NOT NULL
)
INSERT INTO db_laba.dbo.books_abychkovsky2 ( 
id, 
author,
title,
publisher,
published_at,
description)
  (
     SELECT b.id,b.author,b.title,b.publisher,b.published_at,COALESCE(b.description, 'N/A')
     FROM db_laba.dbo.books_abychkovsky b
  )

SELECT
ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME='books_abychkovsky2'

SELECT * FROM db_laba.dbo.books_abychkovsky2
