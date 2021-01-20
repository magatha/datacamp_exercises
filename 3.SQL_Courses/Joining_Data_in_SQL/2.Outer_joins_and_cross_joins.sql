/*
Left Join
Now you'll explore the differences between performing an inner join and a left join using the cities and countries tables.
You'll begin by performing an inner join with the cities table on the left and the countries table on the right. Remember to alias the name of the city field as city and the name of the country field as country.
You will then change the query to a left join. Take note of how many records are in each query here!
*/

-- Select the city name (with alias), the country code,
-- the country name (with alias), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
  INNER JOIN countries AS c2
    -- Match on country code
    ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code DESC;

SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
  -- 1. Join right table (with alias)
  LEFT JOIN countries AS c2
    -- 2. Match on country code
    ON c1.country_code = c2.code
-- 3. Order by descending country code
ORDER BY code DESC;

-----

/*
Left join (2)
Next, you'll try out another example comparing an inner join to its corresponding left join. Before you begin though, take note of how many records are in both the countries and languages tables below.
You will begin with an inner join on the countries table on the left with the languages table on the right. Then you'll change the code to a left join in the next bullet.
Note the use of multi-line comments here using /* and */.
*/

/*
5. Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- 1. From left table (alias as c)
FROM countries AS c
  -- 2. Join to right table (alias as l)
  INNER JOIN languages AS l
    -- 3. Match on fields
    ON c.code = l.code
-- 4. Order by descending country
ORDER BY c.name DESC;

/*
5. Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- 1. From left table (alias as c)
FROM countries AS c
  -- 2. Join to right table (alias as l)
  LEFT JOIN languages AS l
    -- 3. Match on fields
    ON c.code = l.code
-- 4. Order by descending country
ORDER BY c.name DESC;

-----

/*
Left join (3)
You'll now revisit the use of the AVG() function introduced in our Intro to SQL for Data Science course. You will use it in combination with left join to determine the average gross domestic product (GDP) per capita by region in 2010.
*/

-- 5. Select name, region, and gdp_percapita
SELECT name, region, gdp_percapita
-- 1. From countries (alias as c)
FROM countries AS c
  -- 2. Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- 3. Match on code fields
    ON c.code = e.code
-- 4. Focus on 2010
WHERE year = 2010;

-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
FROM countries AS c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY region;

-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
FROM countries as c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY region
-- Order by descending avg_gdp
ORDER BY avg_gdp DESC;

-----

/*
Right join
Right joins aren't as common as left joins. One reason why is that you can always write a right join as a left join.
*/

-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM cities
  LEFT JOIN countries
    ON cities.country_code = countries.code
  LEFT JOIN languages
    ON countries.code = languages.code
ORDER BY city, language;
*/

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON languages.code = countries.code
  RIGHT JOIN cities
    ON countries.code = cities.country_code
ORDER BY city, language;

-----

/*
Full join
In this exercise, you'll examine how your results differ when using a full join versus using a left join versus using an inner join with the countries and currencies tables.
You will focus on the North American region and also where the name of the country is missing. Dig in to see what we mean!
Begin with a full join with countries on the left and currencies on the right. The fields of interest have been SELECTed for you throughout this exercise.
Then complete a similar left join and conclude with an inner join.
*/

SELECT name AS country, code, region, basic_unit
-- 3. From countries
FROM countries
  -- 4. Join to currencies
  FULL JOIN currencies
    -- 5. Match on code
    USING (code)
-- 1. Where region is North America or null
WHERE region = 'North America' OR region IS null
-- 2. Order by region
ORDER BY region;

SELECT name AS country, code, region, basic_unit
-- 3. From countries
FROM countries
  -- 4. Join to currencies
  LEFT JOIN currencies
    -- 5. Match on code
    USING (code)
-- 1. Where region is North America or null
WHERE region = 'North America' OR region IS null
-- 2. Order by region
ORDER BY region;

SELECT name AS country, code, region, basic_unit
FROM countries
  -- 1. Join to currencies
  INNER JOIN currencies
    USING (code)
-- 2. Where region is North America or null
WHERE region = 'North America' OR region IS null
-- 2. Order by region
ORDER BY region;

-----

/*
Full join (2)
You'll now investigate a similar exercise to the last one, but this time focused on using a table with more records on the left than the right. You'll work with the languages and countries tables.
Begin with a full join with languages on the left and countries on the right. Appropriate fields have been selected for you again here.
*/

SELECT countries.name, code, languages.name AS language
-- 3. From languages
FROM languages
  -- 4. Join to countries
  FULL JOIN countries
    -- 5. Match on code
    USING (code)
-- 1. Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS null
-- 2. Order by ascending countries.name
ORDER BY countries.name;

SELECT countries.name, code, languages.name AS language
-- 3. From languages
FROM languages
  -- 4. Join to countries
  LEFT JOIN countries
    -- 5. Match on code
    USING (code)
-- 1. Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS null
-- 2. Order by ascending countries.name
ORDER BY countries.name;

SELECT countries.name, code, languages.name AS language
-- 3. From languages
FROM languages
  -- 4. Join to countries
  INNER JOIN countries
    -- 5. Match on code
    USING (code)
-- 1. Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS null
-- 2. Order by ascending countries.name
ORDER BY countries.name;

-----

/*
Full join (3)
You'll now explore using two consecutive full joins on the three tables you worked with in the previous two exercises.
*/

-- 7. Select fields (with aliases)
SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
-- 1. From countries (alias as c1)
FROM countries AS c1
  -- 2. Join with languages (alias as l)
  FULL JOIN languages AS l
    -- 3. Match on code
    USING (code)
  -- 4. Join with currencies (alias as c2)
  FULL JOIN currencies AS c2
    -- 5. Match on code
    USING (code)
-- 6. Where region like Melanesia and Micronesia
WHERE region LIKE 'M%esia';

-----

/*
A table of two cities
This exercise looks to explore languages potentially and most frequently spoken in the cities of Hyderabad, India and Hyderabad, Pakistan.
You will begin with a cross join with cities AS c on the left and languages AS l on the right. Then you will modify the query using an inner join in the next tab.
*/

-- 4. Select fields
SELECT c.name AS city, l.name AS language
-- 1. From cities (alias as c)
FROM cities AS c        
  -- 2. Join to languages (alias as l)
  CROSS JOIN languages AS l
-- 3. Where c.name like Hyderabad
WHERE c.name LIKE 'Hyder%';

-- 4. Select fields
SELECT c.name AS city, l.name AS language
-- 1. From cities (alias as c)
FROM cities AS c        
  -- 2. Join to languages (alias as l)
  INNER JOIN languages AS l
    -- 3. Match on country code
    ON c.country_code = l.code
-- 3. Where c.name like Hyderabad
WHERE c.name LIKE 'Hyder%';

-----

/*
Outer challenge
Now that you're fully equipped to use outer joins, try a challenge problem to test your knowledge!
In terms of life expectancy for 2010, determine the names of the lowest five countries and their regions.
*/

SELECT c.name as country, region, p.life_expectancy as life_exp
FROM countries as c
LEFT JOIN populations as p
ON c.code = p.country_code
WHERE p.year = 2010
ORDER BY life_exp
LIMIT 5;

-----
