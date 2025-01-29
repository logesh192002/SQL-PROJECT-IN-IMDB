select count(*) as movie_records from movie;
select count(*) as genre_records from genre;
select count(*) as director_mapping_records from director_mapping;
select count(*) as role_mapping_records from role_mapping;
select count(*) as names_records from names;
select count(*) as records from ratings;

select COUNT(*) - COUNT(title) AS null_count_title,
COUNT(*) - COUNT(year) AS null_count_year,
COUNT(*) - COUNT(date_published) AS null_count_published,
COUNT(*) - COUNT(duration) AS null_count_duration,
COUNT(*) - COUNT(country) AS null_count_country,
COUNT(*) - COUNT(worlwide_gross_income) AS null_count_income,
COUNT(*) - COUNT(languages) AS null_count_lang,
COUNT(*) - COUNT(production_company) AS null_count_company
from movie;

select year, month(date_published) as month, count(id) as Totalmovies from movie
group by year, month
order by year, month ;


SELECT country,COUNT(id) as Total_movies FROM movie
where country='USA' OR country='India' and year='2019'
group by country;

select g.genre AS unique_genre, COUNT(m.id) AS movie_count
from genre g
join movie m on g.movie_id = m.id
group by g.genre
order by movie_count desc;

select genre,count(genre) as highest_total
from genre
group by genre
order by highest_total desc limit 1;

select g.genre as genre_name,avg(m.duration) as average_duration
from genre g
join movie m on g.movie_id = m.id
group by g.genre;

select n.name, count(rm.movie_id) as movie_count, avg(rt.avg_rating) as average_rating
from role_mapping rm
join ratings rt on rm.movie_id = rt.movie_id
join names n on rm.name_id = n.id
where rt.avg_rating < 5
group by rm.name_id,n.name
having count(rm.movie_id) > 3;

select
   min(avg_rating) as min_avg_rating,
   max(avg_rating) as max_avg_rating,
   min(total_votes) as min_total_votes,
   min(total_votes) as max_total_votes,
   min(median_rating) as min_median_rating,
   max(median_rating) as max_median_rating
from ratings;

select m.title,rt.avg_rating
from movie m
join ratings rt on m.id = rt.movie_id
order by rt.avg_rating desc
limit 10;

select rt.median_rating,count(rt.movie_id) as movie_count
from ratings rt
group by rt.median_rating
order by rt.median_rating;

select count(m.id) as movie_count
from movie m
join ratings rt on m.id = rt.movie_id
join genre g on m.id = g.movie_id
where m.country = 'usa'
   and m.date_published between '2017-03-01' and '2017-03-31'
   and g.genre = 'drama'
   and rt.total_votes > 1000;
   
 select m.title,g.genre,r.avg_rating
 from movie m
 join genre g on m.id = g.movie_id
 join ratings r on m.id = r.movie_id
 where m.title like 'The%'
 and r.avg_rating > 8
 order by g.genre, r.avg_rating desc;
   
 select count(*) as total_movies
 from movie m
 join ratings r on m.id = r.movie_id
 where m.date_published
 between '2018-04-01' and '2019-04-01'
 and r.median_rating = 8;
 
 select  country,avg(r.total_votes) as average_votes
 from movie m
 join ratings r on m.id = r.movie_id
 where m.country in ('Germany','Italy')
 group by m.country;
 
 select 
count(case when id is null then 1 end) as id_nulls,
count(case when name is null then 1 end) as name_nulls, 
count(case when height is null then 1 end) as height_nulls,
count(case when date_of_birth is null then 1 end) as date_of_birth_nulls,
count(case when known_for_movies is null then 1 end) as known_for_movies_nulls
from names;
 
select n.name as actor_name,r.median_rating
from director_mapping d
join names n on n.id = d.name_id
join ratings r on r.movie_id = d.movie_id
where r.median_rating >= 8
order by r.median_rating desc
limit 2;
   
select m.production_company,
sum(r.total_votes) as total_votes
from movie m
join ratings r on m.id = r.movie_id
group by m.production_company
order by total_votes desc
limit 3;   

select count(distinct name_id) as directors_with_more_than_three_movies
from(
   select name_id
   from director_mapping
   group by name_id
   having count(distinct movie_id) > 3
) as director_counts; 
  
select rm.category,
avg(n.height) as average_height
from role_mapping rm
join names n on rm.name_id = n.id
group by rm.category;

select m.title,m.country,n.name as director,m.date_published
from movie m
join director_mapping d on m.id = d.movie_id
join names n on d.name_id = n.id
order by m.date_published asc limit 10;

select m.title,r.total_votes,g.genre
from movie m
join ratings r on m.id = r.movie_id
join genre g on g.movie_id = m.id
order by r.total_votes desc limit 5;

select m.title,g.genre,m.production_company,m.duration
from movie m
join genre g
on m.id = g.movie_id
order by m.duration desc limit 1;

select m.title,sum(r.total_votes) as total_votes
from movie m
join ratings r
on m.id = r.movie_id
where m.year ='2018'
group by m.title
order by total_votes desc;

select languages,count(languages) as count_lang
from movie
group by languages
order by count_lang desc limit 2;







