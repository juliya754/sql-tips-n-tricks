/*
Помесячный прирост продаж с разбивкой по группе

Есть таблица анализов Analysis:

+-------+---------+---------+----------+----------+
| an_id | an_name | an_cost | an_price | an_group |
+-------+---------+---------+----------+----------+

    an_id - ID анализа
    an_name - Название анализа
    an_cost - Себестоимость анализа
    an_price - Розничная цена анализа
    an_group - Группа анализов

Есть таблица групп анализов Groups:

+-------+---------+---------+
| gr_id | gr_name | gr_temp |
+-------+---------+---------+

    gr_id - ID группы
    gr_name - Название группы
    gr_temp - Температурный режим хранения

Есть таблица заказов Orders:

+--------+--------------+---------+
| ord_id | ord_datetime | ord_an  |
+--------+--------------+---------+

    ord_id ID заказа
    ord_datetime Дата и время заказа
    ord_an ID анализа

Нарастающим итогом рассчитать, как увеличивалось количество проданных тестов каждый месяц каждого года с разбивкой по группе.

Вывести столбцы:

    год
    месяц
    группу
    количество проданных тестов

Результат отсортировать по группе, году и месяцу. 
*//
WITH TMP AS
(SELECT COUNT(an_id) AS Quantity,gr_id,gr_name,EXTRACT(YEAR FROM ord_datetime) AS Year,EXTRACT(MONTH FROM ord_datetime) AS Month
  FROM Groups G
    JOIN Analysis A
      ON (A.an_group=G.gr_id)
    JOIN Orders O
      ON (A.an_id=O.ord_an)
    GROUP BY EXTRACT(YEAR FROM ord_datetime),EXTRACT(MONTH FROM ord_datetime),gr_id)
    SELECT year,month,gr_id AS group,SUM(Quantity) OVER (PARTITION BY gr_id ORDER BY gr_id,year,month rows between unbounded preceding and current row)
      FROM TMP
        ORDER BY gr_id,year,month
        ;
        
