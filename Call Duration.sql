--create table call_start_logs
--(
--phone_number varchar(10),
--start_time datetime
--);
--insert into call_start_logs values
--('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
--,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
--create table call_end_logs
--(
--phone_number varchar(10), 
--end_time datetime
--);
--insert into call_end_logs values
--('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
--,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
--;


with c1 as (select *, row_number() over (partition by phone_number order by start_time) as rnk from call_start_logs),
c2 as(
select *, row_number() over (partition by phone_number order by end_time) as rnk from call_end_logs)


select c1.phone_number,c1.start_time,c2.end_time, datediff(minute,c1.start_time,c2.end_time) as time_duration from c1
join c2 on c1.phone_number = c2.phone_number and c1.rnk = c2.rnk