with t1 as (
  select name,'FIO','Phone','Email',value from LongTable
    where key = 'FIO'
  ),
  t2 as (
  select name,'FIO','Phone','Email',value from LongTable
    where key = 'Phone'
  ),
  t3 as (
  select name,'FIO','Phone','Email',value from LongTable
    where key = 'Email'
  )
select distinct name,
       (select value from t1 where l.name=t1.name) as FIO,
       (select value from t2 where t2.name=l.name) as Phone,
       (select value from t3 where t3.name=l.name) as Email
from LongTable l
;

  SELECT Name,
         MAX(CASE WHEN key = 'FIO' THEN value END) as FIO,
         MAX(CASE WHEN key = 'Phone' THEN value END) AS Phone,
         MAX(CASE WHEN key = 'Email' THEN value END) AS Email
    FROM LongTable
   GROUP
      BY name
      ;
      
