/*
Inner join
PostgreSQL was mentioned in the slides but you'll find that these joins and the material here applies to different forms of SQL as well.
Throughout this course, you'll be working with the countries database containing information about the most populous world cities as well as country-level economic data, population data, and geographic data. This countries database also contains information on languages spoken in each country.
You can see the different tables in this database by clicking on the tabs on the bottom right below query.sql. Click through them to get a sense for the types of data that each table contains before you continue with the course! Take note of the fields that appear to be shared across the tables.

Recall from the video the basic syntax for an INNER JOIN, here including all columns in both tables:
SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id;

You'll start off with a SELECT statement and then build up to an inner join with the cities and countries tables. Let's get to it!
*/

-- Select all columns from cities
SELECT *
From cities;

SELECT * 
FROM cities
  -- 1. Inner join to countries
  INNER JOIN countries
    -- 2. Match on the country codes
    ON cities.country_code = countries.code;

-- 1. Select name fields (with alias) and region 
SELECT cities.name AS city,
countries.name AS country,
countries.region
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;

-----

/*
Inner join (2)
Instead of writing the full table name, you can use table aliasing as a shortcut. For tables you also use AS to add the alias immediately after the table name with a space.

Check out the aliasing of cities and countries below.
SELECT c1.name AS city, c2.name AS country
FROM cities AS c1
INNER JOIN countries AS c2
ON c1.country_code = c2.code;

Notice that to select a field in your query that appears in multiple tables, you'll need to identify which table/table alias you're referring to by using a . in your SELECT statement.
You'll now explore a way to get data from both the countries and economies tables to examine the inflation rate for both 2010 and 2015.
Sometimes it's easier to write SQL code out of order: you write the SELECT statement after you've done the JOIN.
*/

-- 3. Select fields with aliases
SELECT c.code AS country_code, c.name, e.year, inflation_rate
FROM countries AS c
  -- 1. Join to economies (alias e)
  INNER JOIN economies AS e
    -- 2. Match on code
    ON c.code=e.code;

-----

/*
Inner join (3)
The ability to combine multiple joins in a single query is a powerful feature of SQL, e.g:
SELECT *
FROM left_table
  INNER JOIN right_table
    ON left_table.id = right_table.id
  INNER JOIN another_table
    ON left_table.id = another_table.id;
    
As you can see here it becomes tedious to continually write long table names in joins. This is when it becomes useful to alias each table using the first letter of its name (e.g. countries AS c)! It is standard practice to alias in this way and, if you choose to alias tables or are asked to specifically for an exercise in this course, you should follow this protocol.
Now, for each country, you want to get the country name, its region, and the fertility rate and unemployment rate for both 2010 and 2015.
Note that results should work throughout this course with or without table aliasing unless specified differently.
*/

-- 4. Select fields
SELECT c.code, c.name, c.region, p.year, p.fertility_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join with populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code;
 
 -- 6. Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join to populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code
  -- 4. Join to economies (as e)
  INNER JOIN economies AS e
    -- 5. Match on country code
    ON c.code = e.code;
 
 -- 6. Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join to populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code
  -- 4. Join to economies (as e)
  INNER JOIN economies AS e
    -- 5. Match on country code and year
    ON c.code = e.code
    AND p.year = e.year;
 
 -----
 
 /*
 Review inner join using on
Why does the following code result in an error?
SELECT c.name AS country, l.name AS language
FROM countries AS c
  INNER JOIN languages AS l;
*/
/*
INNER JOIN requires a specification of the key field (or fields) in each table.
*/

-----

/*
Inner join with using
When joining tables with a common field name, e.g.

SELECT *
FROM countries
  INNER JOIN economies
    ON countries.code = economies.code

You can use USING as a shortcut:
SELECT *
FROM countries
  INNER JOIN economies
    USING(code)
    
You'll now explore how this can be done with the countries and languages tables.
*/

-- 4. Select fields
SELECT c.name AS country, c.continent, l.name AS language, official
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join to languages (as l)
  INNER JOIN languages as l
    -- 3. Match using code
    USING (code);

-----

/*
Self-join
In this exercise, you'll use the populations table to perform a self-join to calculate the percentage increase in population from 2010 to 2015 for each country code!
Since you'll be joining the populations table to itself, you can alias populations as p1 and also populations as p2. This is good practice whenever you are aliasing and your tables have the same first letter. Note that you are required to alias the tables with self-joins.
*/

-- 4. Select fields with aliases
SELECT p1.country_code, p1.size AS size2010, p2.size AS size2015
-- 1. From populations (alias as p1)
FROM populations AS p1
  -- 2. Join to itself (alias as p2)
  INNER Join populations AS p2
    -- 3. Match on country code
    ON p1.country_code = p2.country_code;

-- 5. Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015
-- 1. From populations (alias as p1)
FROM populations as p1
  -- 2. Join to itself (alias as p2)
  INNER JOIN populations as p2
    -- 3. Match on country code
    ON p1.country_code = p2.country_code
        -- 4. and year (with calculation)
        AND p1.year = p2.year - 5;

SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       -- 1. calculate growth_perc
       ((p2.size - p1.size)/ p1.size * 100.0) AS growth_perc
-- 2. From populations (alias as p1)
FROM populations AS p1
  -- 3. Join to itself (alias as p2)
  INNER JOIN populations AS p2
    -- 4. Match on country code
    ON p1.country_code = p2.country_code
        -- 5. and year (with calculation)
        AND p1.year = p2.year - 5;

-----

/*
Case when and then
Often it's useful to look at a numerical field not as raw data, but instead as being in different categories or groups.
You can use CASE with WHEN, THEN, ELSE, and END to define a new grouping field.
*/

SELECT name, continent, code, surface_area,
    -- 1. First case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- 2. Second case
        WHEN surface_area > 350000 THEN 'medium'
        -- 3. Else clause + end
        ELSE 'small' END
        -- 4. Alias name
        AS geosize_group
-- 5. From table
FROM countries;

-----

/*
Inner challenge
The table you created with the added geosize_group field has been loaded for you here with the name countries_plus. 

Observe the use of (and the placement of) the INTO command to create this countries_plus table:
SELECT name, continent, code, surface_area,
    CASE WHEN surface_area > 2000000
            THEN 'large'
       WHEN surface_area > 350000
            THEN 'medium'
       ELSE 'small' END
       AS geosize_group
INTO countries_plus
FROM countries;

You will now explore the relationship between the size of a country in terms of surface area and in terms of population using grouping fields created with CASE.
By the end of this exercise, you'll be writing two queries back-to-back in a single script. You got this!
*/

SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
FROM populations
WHERE year = 2015;

SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations
WHERE year = 2015;
SELECT 
* FROM pop_plus;

SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations
WHERE year = 2015;
SELECT c.name, c.continent, c.geosize_group, p.popsize_group
FROM countries_plus as c
INNER JOIN pop_plus as p
ON c.code = p.country_code
ORDER BY c.geosize_group

-----
