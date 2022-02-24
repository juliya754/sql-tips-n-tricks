/*

Дано

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

    ord_id - ID заказа
    ord_datetime - Дата и время заказа
    ord_an - ID анализа

Задание

Вывести третий анализ по количеству продаж за весь период.

Результат должен содержать столбцы:

    ID анализа
    Название анализа
    Количество продаж cnt
    Ранг анализа в зависимости от продаж rn
*/


with counted as 
(select a.an_id, count(a.an_id) as cnt from Analysis a
  join Orders o
    on o.ord_an=a.an_id
    group by a.an_id),
r_num as
(select an_id, cnt, row_number() over(order by cnt desc) as rn from counted)
select r.an_id, a.an_name, r.cnt, r.rn
  from r_num r
  join Analysis a
    on a.an_id=r.an_id
    where rn=3
    ;
