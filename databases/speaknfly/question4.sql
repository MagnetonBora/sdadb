SELECT
    C.name AS 'Category',
    COUNT(C.name) AS 'Total'
FROM
    Courses
INNER JOIN
    Categories C on Courses.category_id = C.id
WHERE
    strftime('%Y', datetime(start_date / 1000, 'unixepoch')) = '2020'
GROUP BY 
    Category
ORDER BY Total;
