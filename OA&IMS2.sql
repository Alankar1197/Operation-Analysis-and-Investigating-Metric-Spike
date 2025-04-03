use oa_and_ims;

create table users ( user_id int, created_at varchar(100), company_id int, language varchar(50), activated_at varchar(100), state varchar(50));


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
into table users
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from users;

alter table users add column temp_activated_at datetime;

update users set temp_activated_at = str_to_date(activated_at, '%d-%m-%Y %H:%i');

alter table users drop column activated_at;

alter table users change column temp_activated_at activated_at datetime;

create table events (user_id int, occured_at varchar(100), event_type varchar(50), event_name varchar(50), location varchar(50), device varchar(50),
user_type int);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
into table events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from events;

alter table events add column temp_occured_at datetime;

update events set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');

alter table events drop column occured_at;

alter table events change column temp_occured_at occured_at datetime;

create table email_events(user_id int, occured_at varchar(100), action varchar(50), user_type int);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
into table email_events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table email_events add column temp_occured_at datetime;

update email_events set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');

alter table email_events drop column occured_at;

alter table email_events change column temp_occured_at occured_at datetime;





select * from users;

select * from events;

select * from email_events;

select concat(left(yearweek(occured_at), 4), ' - ', right(yearweek(occured_at), 2)) as week_number, count(*) as total_engagements
from events 
where event_type= 'engagement'
group by week_number
order by week_number;





select * from users;

select concat(left(yearweek(created_at), 4), ' - ', right(yearweek(created_at), 2)) as week_number, count(user_id) as new_users
from users
group by week_number
order by week_number;




select * from users;
select * from events;

with user_cohorts as(select user_id, yearweek(created_at) as signup_week from users),
user_activity as(select e.user_id, yearweek(e.occured_at) as activity_week from events e)
select uc.signup_week, ua.activity_week, count(distinct ua.user_id) as retained_users from user_cohorts uc
join user_activity ua on uc.user_id= ua.user_id and ua.activity_week>= uc.signup_week
group by uc.signup_week, ua.activity_week
order by uc.signup_week, ua.activity_week;



select * from events;

select concat(left(yearweek(occured_at), 4), ' - ', right(yearweek(occured_at), 2)) as week_number, device,
count(*) as total_engagements
from events
where event_type= 'engagement'
group by week_number, device
order by week_number, device;



select * from email_events;

select concat(left(yearweek(occured_at), 4), ' - ', right(yearweek(occured_at), 2)) as week_number, action,
count(*) as total_engagements
from email_events
group by week_number, action
order by week_number, action;

select * from job_data;


















