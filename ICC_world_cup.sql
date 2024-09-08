


--create table icc_world_cup
--(
--Team_1 Varchar(20),
--Team_2 Varchar(20),
--Winner Varchar(20)
--);
--INSERT INTO icc_world_cup values('India','SL','India');
--INSERT INTO icc_world_cup values('SL','Aus','Aus');
--INSERT INTO icc_world_cup values('SA','Eng','Eng');
--INSERT INTO icc_world_cup values('Eng','NZ','NZ');
--INSERT INTO icc_world_cup values('Aus','India','India');

--select * from icc_world_cup;

with wins as(
select team_1 as team, case when team_1 = Winner then 1 else 0 end as winflag
from icc_world_cup
union all
select team_2 as team, case when team_2 = Winner then 1 else 0 end as winflag
from icc_world_cup)


select team, count(1) as total_matches_played, sum(winflag) as total_matches_won,
count(1)-sum(winflag) as total_matches_lost
from wins
group by team