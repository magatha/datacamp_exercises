/*
Subquery inside where
You'll now try to figure out which countries had high average life expectancies (at the country level) in 2015.
*/

-- Select average life_expectancy
SELECT AVG(life_expectancy)
  -- From populations
  FROM populations
-- Where year is 2015
WHERE year = 2015;

-- Select fields
SELECT *
  -- From populations
FROM populations
-- Where life_expectancy is greater than
WHERE life_expectancy > 1.15 *
  -- 1.15 * subquery
    (SELECT AVG(life_expectancy)
       FROM populations
    WHERE year = 2015)
AND year = 2015;

-----

/*
Subquery inside where (2)
Use your knowledge of subqueries in WHERE to get the urban area population for only capital cities.
*/

SELECT city.name, city.country_code, city.urbanarea_pop
-- from the cities table
FROM cities AS city
-- with city name in the field of capital cities
WHERE city.name IN
  (SELECT capital
   FROM countries)
ORDER BY urbanarea_pop DESC;

-----

/*
Subquery inside select
In this exercise, you'll see how some queries can be written using either a join or a subquery.
You have seen previously how to use GROUP BY with aggregate functions and an inner join to get summarized information from multiple tables.
The code given in query.sql selects the top nine countries in terms of number of cities appearing in the cities table. Recall that this corresponds to the most populous cities in the world. Your task will be to convert the commented out code to get the same result as the code shown.
*/

SELECT countries.name AS country, COUNT(*) AS cities_num
FROM cities
INNER JOIN countries
ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9;

SELECT countries.name AS country,
  (SELECT COUNT(*)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

-----

/*
Subquery inside from
The last type of subquery you will work with is one inside of FROM.
You will use this to determine the number of languages spoken for each country, identified by the country's local name! (Note this may be different than the name field and is stored in the local_name field.)
*/

-- Select fields (with aliases)
SELECT code, COUNT(name) AS lang_num
  -- From languages
  FROM languages
-- Group by code
GROUP BY code;

-- Select fields
SELECT local_name, subquery.lang_num
  -- From countries
  FROM countries, 
  	-- Subquery (alias as subquery)
  	 (SELECT code, COUNT(name) AS lang_num
    FROM languages
    GROUP BY code) as subquery
  -- Where codes match
  WHERE countries.code = subquery.code
-- Order by descending number of languages
ORDER BY lang_num DESC;

-----

/*
Advanced subquery
You can also nest multiple subqueries to answer even more specific questions.
In this exercise, for each of the six continents listed in 2015, you'll identify which country had the maximum inflation rate (and how high it was) using multiple subqueries. The table result of your query in Task 3 should look something like the following, where anything between < > will be filled in with appropriate values:
+------------+---------------+-------------------+
| name       | continent     | inflation_rate    |
|------------+---------------+-------------------|
| <country1> | North America | <max_inflation1>  |
| <country2> | Africa        | <max_inflation2>  |
| <country3> | Oceania       | <max_inflation3>  |
| <country4> | Europe        | <max_inflation4>  |
| <country5> | South America | <max_inflation5>  |
| <country6> | Asia          | <max_inflation6>  |
+------------+---------------+-------------------+
Again, there are multiple ways to get to this solution using only joins, but the focus here is on showing you an introduction into advanced subqueries.
*/

-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
FROM countries 
  	-- Join to economies
INNER JOIN economies
    -- Match on code
USING (code)
-- Where year is 2015
WHERE year = 2015;

-- Select the maximum inflation rate as max_inf
SELECT MAX(inflation_rate) AS max_inf
  -- Subquery using FROM (alias as subquery)
  FROM (
      SELECT name, continent, inflation_rate
      FROM countries
      INNER JOIN economies
      USING (code)
      WHERE year = 2015) AS subquery
-- Group by continent
GROUP BY continent;

-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
  FROM countries
	-- Join to economies
	INNER JOIN economies
	-- Match on code
	ON countries.code = economies.code
  -- Where year is 2015
  WHERE year = 2015
    -- And inflation rate in subquery (alias as subquery)
     AND inflation_rate IN (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             ON countries.code = economies.code
             WHERE year = 2015) AS subquery
      -- Group by continent
        GROUP BY continent);

-----

/*
Subquery challenge
Let's test your understanding of the subqueries with a challenge problem! Use a subquery to get 2015 economic data for countries that do not have
gov_form of 'Constitutional Monarchy' or 'Republic' in their gov_form.
Here, gov_form stands for the form of the government for each country. Review the different entries for gov_form in the countries table.
*/

SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 AND code NOT IN
  (SELECT code
   FROM countries
   WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic'))
ORDER BY inflation_rate;

-----

/*
Final challenge
Welcome to the end of the course! The next three exercises will test your knowledge of the content covered in this course and apply many of the ideas you've seen to difficult problems. Good luck!
Read carefully over the instructions and solve them step-by-step, thinking about how the different clauses work together.
In this exercise, you'll need to get the country names and other 2015 data in the economies table and the countries table for Central American countries with an official language.
*/

-- Select fields
SELECT DISTINCT c.name, e.total_investment, e.imports
  -- From table (with alias)
  FROM countries AS c
    -- Join with table (with alias)
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND c.code IN (
          SELECT code 
          FROM languages
          WHERE official = 'true'
        ) )
  -- Where region and year are correct
  WHERE year = 2015 AND region = 'Central America'
-- Order by field
ORDER BY c.name;

-----

/*
Final challenge (2)
Whoofta! That was challenging, huh?
Let's ease up a bit and calculate the average fertility rate for each region in 2015.
*/

-- Select fields
SELECT region, continent, AVG(fertility_rate) AS avg_fert_rate
  -- From left table
  FROM countries AS c
    -- Join to right table
    INNER JOIN populations AS p
      -- Match on join condition
      ON c.code = p.country_code
  -- Where specific records matching some condition
  WHERE year = 2015
-- Group appropriately
GROUP BY region, continent
-- Order appropriately
ORDER BY avg_fert_rate;

----

/*
Final challenge (3)
Welcome to the last challenge problem. By now you're a query warrior! Remember that these challenges are designed to take you to the limit to solidify your SQL knowledge! Take a deep breath and solve this step-by-step.
You are now tasked with determining the top 10 capital cities in Europe and the Americas in terms of a calculated percentage using city_proper_pop and metroarea_pop in cities.
Do not use table aliasing in this exercise.
*/

-- Select fields
SELECT name, country_code, city_proper_pop, metroarea_pop,  
      -- Calculate city_perc
      city_proper_pop / metroarea_pop * 100 AS city_perc
  -- From appropriate table
  FROM cities
  -- Where 
  WHERE name IN
    -- Subquery
    (SELECT capital
   FROM countries
   WHERE (continent = 'Europe'
      OR continent LIKE '%America'))
     AND metroarea_pop IS NOT NULL
-- Order appropriately
ORDER BY city_perc DESC
-- Limit amount
LIMIT 10;

-----
