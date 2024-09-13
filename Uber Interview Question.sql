



--create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
--insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
--insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
--insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

select d1.id,count(1) as total_rides, count(d2.id)  from drivers d1
left join
 drivers d2 on
 d1.id = d2.id and d1.end_loc = d2.start_loc
 and d1.end_time = d2.start_time
 group by d1.id





 
