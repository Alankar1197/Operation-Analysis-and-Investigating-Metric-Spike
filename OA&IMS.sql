use oa_and_ims;

create table job_data(
ds date, job_id int, actor_id int, event_name varchar(20), language_name varchar(20), time_spent int, org varchar(5));

select * from job_data;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_data.csv'
into table job_data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select ds as review_date, sum(time_spent)/3600 as jobs_per_hour
from job_data
group by ds
order by ds;