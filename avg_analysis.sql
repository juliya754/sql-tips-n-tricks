/*
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

Задание

Вывести ID анализов, у которых среднемесячное количество заказов больше 2 в 2020 году.

Вывести столбцы:

    ID анализа - an_id
    среднемесячное кол-во заказов - cnt

Важно: Обратите внимание, что название столбцов в ответе должно в точности совпадать с условием.

Важно: Рассчитанное количество округлите до 3 знака после запятой. 

*/

with tmp as
(select a.an_id as an_id,extract(month from ord_datetime) as mon, count(a.an_id) as cnt from Analysis a
  join Orders o
    on o.ord_an=a.an_id
  where extract(year from ord_datetime)=2020
  group by a.an_id, extract(month from ord_datetime))
  select an_id, round(avg(cnt),3) as cnt
    from tmp
      group by an_id
      having avg(cnt)>2
      ;
