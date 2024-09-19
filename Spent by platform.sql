--create table entries ( 
--name varchar(20),
--address varchar(20),
--email varchar(20),
--floor int,
--resources varchar(10));

--insert into entries 
--values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
--,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')..


select * from entries;

with 
c4 as (select  distinct  name,resources from entries 
),
c1 as(
select name,floor,count(1) as freq ,
rank() over (partition by floor order by count(1) desc) as rn
from entries e join c4 on e.name = c4.name
group by name,floor),
c2 as(
select name, count(1) as totalvisits from entries group by name),
c3 as(
select c1.name,c1.floor, sum(c2.totalvisits) as totalvists,sum(c1.freq) as freq 
from c1
join c2 on c1.name  = c2.name
where c1.rn = 1
group by c1.name,c1.floor)
, 

select c3.name,c3.totalvists,c3.floor as mostvisitedfloor, c4.resources
from c3 join c4 on c3.name = c4.name
