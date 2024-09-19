----Given the following two tables, return the fraction of users, rounded to two decimal places,
----who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up. 

----Here is the script:


--create table users2
--(
--user_id integer,
--name varchar(20),
--join_date date
--);
--insert into users2
--values (1, 'Jon', CAST('2-14-20' AS date)), 
--(2, 'Jane', CAST('2-14-20' AS date)), 
--(3, 'Jill', CAST('2-15-20' AS date)), 
--(4, 'Josh', CAST('2-15-20' AS date)), 
--(5, 'Jean', CAST('2-16-20' AS date)), 
--(6, 'Justin', CAST('2-17-20' AS date)),
--(7, 'Jeremy', CAST('2-18-20' AS date));

--create table events
--(
--user_id integer,
--type varchar(10),
--access_date date
--);

--insert into events values
--(1, 'Pay', CAST('3-1-20' AS date)), 
--(2, 'Music', CAST('3-2-20' AS date)), 
--(2, 'P', CAST('3-12-20' AS date)),
--(3, 'Music', CAST('3-15-20' AS date)), 
--(4, 'Music', CAST('3-15-20' AS date)), 
--(1, 'P', CAST('3-16-20' AS date)), 
--(3, 'P', CAST('3-22-20' AS date));


select * from users2
select * from events


select count( distinct u2.user_id) as totalusers,
sum(case when datediff(day,join_date,access_date) <=30 then 1 else 0 end),
1.0*sum(case when datediff(day,join_date,access_date) <=30 then 1 else 0 end)/count( distinct u2.user_id) as fractionusers
--u2.user_id,join_date,e.access_date, datediff(day,join_date,access_date) as datedifference 
from users2 u2
left join events e on e.user_id = u2.user_id and e.type = 'P'
where u2.user_id in (
select user_id from events where type = 'Music')







