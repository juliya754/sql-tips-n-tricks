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

Помесячно вывести прирост количества продаж в процентах относительно предыдущего месяца для всех анализов в 2020 году, где в названии в любом месте располагается слово "кров" или "тестостерон" в любом регистре.

Вывести:

    name - название анализа
    month - месяц
    current_cnt - продажи за текущий месяц
    prev_cnt - продажи за предыдущий месяц
    change - прирост в процентах

Результат отсортируйте по возрастанию столбцов:

    name
    month

Величину change округлите до 3 знака после запятой. В случае NULL выведите 0.
*/


with tmp as 
(select count(an_name) as count,an_name as name,extract(month from ord_datetime) as month from Analysis a
  join Orders o
    on o.ord_an=a.an_id
   where (an_name like '%кров%'
    or an_name like '%КРОВ%'
    or an_name like '%тестостерон%'
    or an_name like '%ТЕСТОСТЕРОН%')
    and extract(year from ord_datetime)=2020
    group by extract(month from ord_datetime),an_name
   order by extract(month from ord_datetime)),
   
   tmp2 as (select name, 
          month, 
          count as current_cnt, 
          lag(count) over(partition by name order by month) as prev_cnt
   from tmp)
   
   select name,
           case
             when CAST(month as int)>9 then CAST(month as text)
             when CAST(month as int)<=9 then '0'||CAST(month as text)   
           end as month,
          current_cnt, 
          prev_cnt, 
          COALESCE(
            round((
              cast(current_cnt as numeric(10,4)
              )-cast(prev_cnt as numeric(10,4)))/prev_cnt*100,3),0) as change
   from tmp2
   ;
      
