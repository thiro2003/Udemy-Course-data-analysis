
-- Basic Course Details Analysis
-- Retrieve the course titles along with their prices for paid courses.
select course_title,price from course;
-- List the top 10 most expensive courses

select distinct price ,course_title from course order by price desc limit 10;
 
-- Find the number of free and paid courses.
select 

  sum(case when is_paid="TRUE" then 1 else 0 end ) as paid,
  sum(case when is_paid="FALSE" then 0 else 1 end ) as unpaid
  from course;

-- Calculate the average price of paid courses.
select avg(price) from course;
-- Identify courses with more than 1,000 subscribers.
select course_title from course where num_subscribers>1000;
-- Retrieve courses published after a specific date (e.g., '2022-01-01').
-- Find courses with more than 50 lectures.
select course_title from course where  num_lectures>50;
-- List courses that are labeled as "Beginner" level.
select * from course where level="Beginner Level";
-- Identify courses with a content duration longer than 5 hours.
select * from course where content_duration>5;
-- Retrieve the number of courses under each subject.
select subject, count(course_id) from course group by subject;
-- Subscriber and Review Analysis
-- Calculate the average number of subscribers per course.
select course_title,round(avg(num_subscribers)) from course group by course_title; 
-- Identify the course with the highest number of reviews.
select course_title from course where num_reviews=(select max(num_reviews)from course);
-- Find courses with more than 5,000 subscribers and at least 100 reviews.
select course_title from course where num_subscribers>5000 and num_reviews>=100;
-- Calculate the total number of subscribers for all paid courses.
select count(num_subscribers) from course where is_paid="TRUE";
-- Retrieve courses with a -to-review ratio greater than 10.
select course_title, num_subscribers, num_reviews, (num_subscribers)/(num_reviews) as ration from course where 
(num_subscribers)/(num_reviews)>10;


-- Identify courses with zero reviews.
select course_title from course where num_reviews=0;
-- Calculate the average number of reviews per course level.
select level,avg(num_reviews) from course group by level;
-- Find the top 5 most-reviewed courses for each subject.
select subject,num_reviews from course where num_review=(select subject,num_reviews from course  order by num_reviews desc limit 5);
-- List courses where the number of subscribers is greater than the average for that subject.

-- Retrieve the total number of subscribers for courses published in the last year.
-- Lecture and Content Analysis
-- Find courses with the highest number of lectures for each level.
select level,max(num_lectures) from course group by level;
-- Calculate the average content duration for "Expert" level courses.
select level,avg(content_duration) from course group by level having level="Expert Level";
-- Identify courses with less than 10 lectures and a content duration of more than 2 hours.
select course_title from course where num_lectures<10 and content_duration>2;
-- Retrieve the total content duration for all courses in each subject.
select subject,sum(content_duration) from course group by subject;
-- Find courses with less than the average number of lectures for their subject.
select course_title from course where avg(num_lectures)>num_lectures;

-- Calculate the total number of lectures for all "Intermediate" level courses.
select sum(num_lectures) from course where level="Intermediate Level";
-- Identify courses with content duration less than 1 hour.
select course_title  from course where content_duration<"1 hour";
select content_duration from course;
-- List the top 3 courses with the longest content duration.
use udemy;
select course_title,content_duration from course order by content_duaration desc limit 3;
-- Retrieve the average content duration per course level.
-- Find courses with more than twice the average content duration for their level.


-- Price and Payment Analysis
-- Calculate the total revenue from all paid courses.
select sum(price*num_subscribers) as total_revenue from course;
-- Identify the course with the highest revenue.
select course_title,sum(price*num_subscribers) from course;
-- Find the average price for courses in each subject.
select subject,avg(price) from course group by subject;
-- Retrieve the number of free courses by subject.
select subject,count(course_title) from course where is_paid="FALSE" group by subject;
-- Identify courses priced above the average for their level.
select c.level,c.price,c.course_title from course as  c join (
select level,avg(price)  as average from course group by level
) avh on c.level=avh.level
where c.price >avh.average;

-- Calculate the total potential revenue if all subscribers paid for paid courses.
select sum(price*num_subscribers) as revenue from course where is_paid="TRUE";


-- Identify the most expensive course for each subject.
select subject,course_title,max(price)from course group by subject;
-- Calculate the price-to-subscriber ratio for each paid course.
-- Subject and Level Analysis
-- Find the total number of courses for each subject and level combination.
-- Identify subjects with more than 100 total courses.
-- Retrieve the most popular subject based on total subscribers.
-- Calculate the average number of subscribers for "Beginner" level courses.
-- Find courses labeled as "All Levels" with more than 1,000 subscribers.
-- List the subject with the highest average price for "Intermediate" level courses.
-- Find subjects where the majority of courses are paid.
select subject,count(is_paid) from course where is_paid="TRUE" group by subject;
-- Calculate the distribution of courses across levels for each subject.
-- Retrieve the average number of subscribers for courses published in each year.
SELECT 
    
    YEAR(STR_TO_DATE(published_timestamp, '%Y-%m-%dT%H:%i:%sZ')) AS year,
    avg(num_subscribers) 
     from course group by YEAR(STR_TO_DATE(published_timestamp, '%Y-%m-%dT%H:%i:%sZ'));