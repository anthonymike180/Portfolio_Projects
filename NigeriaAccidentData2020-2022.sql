select *
from nigeria_road_accidents

--Total fatal accident by state
select state, sum(fatal) as Total_fatalities
from nigeria_road_accidents
group by STATE

--Total Serious Injuries by State
SELECT state, SUM(serious) AS total_serious_injuries
FROM nigeria_road_accidents
GROUP BY state

--Average Number of People Involved per Accident by State
SELECT state, AVG(people_involved) AS avg_people_involved
FROM nigeria_road_accidents
GROUP BY state


--Top 10 state with the highest Total case
select top 10 state, sum(total_cases) as total_cases
from nigeria_road_accidents
group by state
order by total_cases desc 

--Top 10 state with the highest number of people killed
select top 10 state,sum(number_killed) as Total_killed
from nigeria_road_accidents
group by STATE
order by Total_killed desc


--Anthony Michael 2022


