/*
Дано

Дана таблица клиентов customer:

+---------------+-------------+-------------+-----------+--------------+---------------+--------+-------------+------------+-------------+
|  ID_CUSTOMER  |  ADDRESS_1  |  ADDRESS_2  |  COMPANY  |  FIRST_NAME  |  COUNTY_CODE  |  TOWN  |  LAST_NAME  |  POSTCODE  |  TELEPHONE  |
+---------------+-------------+-------------+-----------+--------------+---------------+--------+-------------+------------+-------------+

Дана таблица товаров skus:

+------+---------+------------+
|  id  |  price  |  category  |
+------+---------+------------+

Дана таблица продаж purchases:

+------+--------------+-----------+----------+
|  id  |  created_at  |  user_id  |  sku_id  |
+------+--------------+-----------+----------+

Задание

Необходимо вывести среднюю стоимость 5-ой покупки с разбивкой по городам.

Примечание: Если один и тот же человек совершал покупки, но в разное время, то это считаем за разные покупки.
Дополнительная информация

Итоговая таблица должна иметь вид:

+--------+--------------------------+
|  town  |  avg_price_5th_purchase  |
+--------+--------------------------+

Важно: Названия столбцов должны в точности совпадать.

Важно: Результат должен быть отсортирован по убыванию значений в столбце avg_price_5th_purchase.
*/

WITH FIFTH_PURCHASE AS
(SELECT created_at,c.ID_CUSTOMER,s.price,c.TOWN,ROW_NUMBER() OVER(PARTITION BY TOWN,c.ID_CUSTOMER ORDER BY created_at) AS Row
FROM purchases p
  JOIN customer c
    ON c.ID_CUSTOMER=p.user_id
  JOIN skus s
    ON s.id=p.sku_id)
    SELECT town,AVG(price) AS avg_price_5th_purchase
      FROM FIFTH_PURCHASE
         WHERE row=5
            GROUP BY town
              ORDER BY avg_price_5th_purchase DESC
              ;
