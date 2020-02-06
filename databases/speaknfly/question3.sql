SELECT
    L.name AS 'Level',
    COUNT(L.name) AS 'Total'
FROM
     Courses
INNER JOIN
    Levels L on Courses.level_id = L.id
WHERE 
    strftime('%Y', datetime(start_date / 1000, 'unixepoch')) = '2020'
GROUP BY 
    L.name
ORDER BY Total;
