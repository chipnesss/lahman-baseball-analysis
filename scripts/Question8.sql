--MAX

select sum(homegames.attendance)/sum(homegames.games) as average_max_attendance, parks.park_name, teams.name
from homegames inner join parks
on homegames.park = parks.park
inner join teams
on teams.teamid = homegames.team
where games > 10
and year = '2016'
group by parks.park_name, teams.name
order by average_max_attendance desc
limit 5;



--MIN

select sum(homegames.attendance)/sum(homegames.games) as average_min_attendance, parks.park_name, teams.name
from homegames inner join parks
on homegames.park = parks.park
inner join teams
on teams.teamid = homegames.team
where games > 10
and year = '2016'
group by parks.park_name, teams.name
order by average_min_attendance asc
limit 5;



--Mahesh
WITH avg_attend AS (SELECT park, team, attendance/games AS avg_attendance
					FROM homegames
					WHERE year = 2016
						  AND games >= 10),
	 avg_attend_full AS (SELECT park_name, name as team_name, avg_attendance
						 FROM avg_attend INNER JOIN teams ON avg_attend.team = teams.teamid
						 	  INNER JOIN parks ON avg_attend.park = parks.park
						 WHERE teams.yearid = 2016
						 GROUP BY park_name, avg_attendance, name),
	 top_5 AS (SELECT *, 'top_5' AS category
			   FROM avg_attend_full
			   ORDER BY avg_attendance DESC
			   LIMIT 5),
	 bottom_5 AS (SELECT *, 'bottom_5' AS category
			      FROM avg_attend_full
			      ORDER BY avg_attendance
			      LIMIT 5)
SELECT *
FROM top_5
UNION ALL
SELECT *
FROM bottom_5;
