

--CREATE TABLE employee_checkin_details (
--    employeeid	INT,
--    entry_details	VARCHAR(512),
--    timestamp_details	VARCHAR(512)
--);

--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'login', '2023-06-16 01:00:15.34');
--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'login', '2023-06-16 02:00:15.34');
--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'login', '2023-06-16 03:00:15.34');
--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'logout', '2023-06-16 12:00:15.34');
--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'login', '2023-06-16 01:00:15.34');
--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'login', '2023-06-16 02:00:15.34');
--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'login', '2023-06-16 03:00:15.34');
--INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'logout', '2023-06-16 12:00:15.34');







select employeeid, count(1) as entry,
sum(case when entry_details = 'login' then 1 else 0 end) as login_entry,
sum(case when entry_details = 'logout' then 1 else 0 end) as logout_entry,
max(case when entry_details = 'login' then timestamp_details end) as last_login,
max(case when entry_details = 'logout' then timestamp_details end) as last_logout
from  employee_checkin_details
join 
group by employeeid