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
