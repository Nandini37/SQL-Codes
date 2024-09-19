--create table UserActivity
--(
--username      varchar(20) ,
--activity      varchar(20),
--startDate     Date   ,
--endDate      Date
--);

--insert into UserActivity values 
--('Alice','Travel','2020-02-12','2020-02-20')
--,('Alice','Dancing','2020-02-21','2020-02-23')
--,('Alice','Travel','2020-02-24','2020-02-28')
--,('Bob','Travel','2020-02-11','2020-02-18');

select * from useractivity;


with c1 as(
select username,activity,startdate ,
count(1) over (partition by username) as totalactivity,
rank() over (partition by username order by startdate asc) as rnk
from useractivity

group by username,activity,startdate )


select * from c1 where rnk = 2 or totalactivity = 1


