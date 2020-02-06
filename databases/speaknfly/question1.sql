SELECT
    Langs.name AS 'Language',
    COUNT(Langs.name) AS 'Total',
    strftime('%Y', datetime(start_date / 1000, 'unixepoch')) AS 'Year'
FROM
    Courses
INNER JOIN
    Languages Langs on Courses.language_id = Langs.id
WHERE
    Year = '2020'
GROUP BY
    language_id
ORDER BY
    Total DESC
LIMIT 1;
