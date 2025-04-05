
### `baby_names`

| column         | type    | description                                                                  |
| -------------- | ------- | ------------------------------------------------------------------------ |
| `year`         | int     | year                                                                     |
| `first_name`   | varchar | first name                                                               |
| `sex`          | varchar | `sex` of babies given `first_name`                                       |
| `num`          | int     | number of babies of `sex` given `first_name` in that `year`              |


1. List the first five names in alphabetical order and find out if each name is "Classic" or "Trendy." Save your query as a DataFrame name_types with three columns: first_name, sum, and popularity_type. name is considered "Classic" if it appears in 50 or more years, and "Trendy" otherwise.

I need to use case statements based on count 

SELECT 
    first_name, 
    SUM(num) AS sum,
    CASE 
        WHEN SUM(num) >= 50 THEN 'Classic'
        ELSE 'Trendy'
    END AS popularity_type
FROM
    baby_names
GROUP BY 
    first_name
ORDER BY 
	first_name ASC
LIMIT
	5;


2. What were the top 20 male names overall, and how did the name Paul rank? Save your query as a DataFrame top_20 with three columns: name_rank, first_name, and sum.
-I need to filter by gender and the name paul?
-limit to top 20
- unclear if they want me to use RANK -- i think they explicitly want me to do this because name_rank

I accidently used PARTITION IN Rank() but im not trying to rank each row, but the whole table
SELECT 
    RANK() OVER (
      ORDER BY num 
    ) AS name_rank,
    first_name
FROM 
    baby_names


But im not done since they want me to group by requiring me to include the column sum using SUM(num)
Since i cannot use GROUP BY and RANK BY in the same query, i will need to create a CTE for group by

I had to figure out whether to put GROUP BY or Rank() in the CTE with the goal of having GROUP By aggregate the query and then rank the aggregated data
Putting GROUP BY in the CTE causes it to run first.

!! I needed to understand the order of operations for SQL. FROM is first, so the cte runs first and aggregates the query. So that Rank By can then rank the aggregate !!

WITH group_num AS(
    SELECT
        first_name,
        SUM(num) AS sum
    FROM    
        baby_names
    WHERE
        sex = 'Male'
    GROUP BY
        first_name


)

SELECT 
    first_name, 
    sum,
    RANK() OVER (
        ORDER BY sum 
        ) AS name_rank
    FROM 
        group_num 
    LIMIT 
        20
    


3. Which female names appeared in both 1920 and 2020? Save your query as a DataFrame a_names with two columns: first_name, and total_occurrences.

i can run two queries of females from 1920 and 2020 and then use inner JOIN to only get the names of females who appeared in both. WHILE GROUPING BY NAME AND COUNTING




Attempt 1: Failed because it counted 1 instance per name despite not using DISTINCT with  COUNT(women_2020.first_name)

Inner join combines every matching pair (and duplicate pair) so thats fine. 
I misused COUNT -- It just counts the rows that the name appears in, not the instances of the name in both tables.
I needed to use SUM with num while grouping by name. And i need to include it in both CTE or the main query doesnt have num either

WITH women_1920 AS (
    SELECT 
        first_name
    FROM
        baby_names
    WHERE
        sex = 'Female' AND year = 1920

),
women_2020 AS (
    SELECT 
        first_name
    FROM
        baby_names
    WHERE
        sex = 'Female' AND year = 2020

)

SELECT 
    women_2020.first_name, 
    COUNT(women_2020.first_name) AS total_occurrences
    FROM 
        women_2020
    JOIN
        women_1920 ON women_2020.first_name = women_1920.first_name 
    GROUP BY
        women_2020.first_name 


Attempt 2:

WITH women_1920 AS (
    SELECT 
        first_name,
        SUM(num) as total_1920
    FROM
        baby_names
    WHERE
        sex = 'F' AND year = 1920
    GROUP BY
        first_name
),
women_2020 AS (
    SELECT 
        first_name,
        SUM(num) as total_2020
    FROM
        baby_names
    WHERE
        sex = 'F' AND year = 2020
    GROUP BY
        first_name
)

SELECT 
    women_2020.first_name, 
    (women_1920.total_1920 + women_2020.total_2020) AS total_occurrences
    FROM 
        women_2020
    JOIN
        women_1920 ON women_2020.first_name = women_1920.first_name 
