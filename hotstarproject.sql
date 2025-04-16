drop table if exists hotstar;
create table hotstar(
	hotstar_id varchar(20),
	title varchar(100),
	discription text,
	genre varchar(25),
	year int,
	age_rating varchar(40),
	running_time int,
	seasons int,
	episoded int,
	type varchar(30)
)

-- renaming the column due to typo error

alter table hotstar rename column  episoded to episodes 
	

--- checking for null values 

	
select * from hotstar where hotstar_id is null and title is null and discription is null and genre is null and year is null and 
	age_rating is null and running_time is null and seasons is null and episodes is null and type is null

	

--- showing the longest movie in hotstar


select * from hotstar where running_time = (select max(running_time) from hotstar)


--- show the total romance content released in the year 2012



	
select title,year,genre from hotstar where genre = 'Romance' and year = '2012'



--- count the total number of movies in every gener


select genre,count(*) from hotstar group by 1



---- display all the movies released in last 5 years



select title,
	year
from(
	select title,year, extract (year from current_date)-year  as added_year from hotstar
) as t1
where added_year = 5



-----group movies into good and violence movie



select *,  case when desciption ilike '%kill%' 
	or case when desciption ilike '%murder%'
	or  desciption ilike '%violence%'
	or desciption ilike '%death%'
	or desciption ilike '%dead%'
	or desciption ilike '%stabb%'
	or desciption ilike '%stabbed%'
	or 	 desciption ilike '%stabbing%'
	then 'violence_content'	
else 'Good_content'
end 
from netflix




--- count the  number of tv shows and movies released in the year 2021



select type,count(*) from hotstar where year = 2021 group by 1 


----- count the top 3 series based on epsiodes of including all the seasons



select title ,(seasons)::numeric*(episodes)::numeric as total_episodes_combining_all_seasons 
	from hotstar where type = 'tv' order by 2 desc



select * from hotstar where type = 'tv'




--- find the average age rating given to tv shows and movies


select * from
	(
select  type,
	age_rating,
	rank()over(partition by type order by count(age_rating)desc) as ranking,	
	count(age_rating) as total_number_of_rating
	from hotstar group by 1,2
)as t1
where ranking = 1












