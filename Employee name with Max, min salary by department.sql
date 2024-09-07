-- Query to find employee with highest and lowest salary by department


--create table employee2
--(
--emp_name varchar(10),
--dep_id int,
--salary int
--);
--delete from employee2;
--insert into employee2 values 
--('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000)


select * from employee2;
with cte as
(select dep_id, emp_name, salary,
row_number() over (partition by dep_id order by salary desc) as max_rank,
row_number() over (partition by dep_id order by salary asc) as min_rank
from employee2)

select dep_id, 
max(case when max_rank = 1 then emp_name end) as max_salary,
max(case when min_rank = 1 then emp_name end)  as min_salary
from cte
group by dep_id
