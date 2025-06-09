

### `game_sales` table

| Column | Definition | Data Type |
|-|-|-|  
|name|Name of the video game|`varchar`|
|platform|Gaming platform|`varchar`|
|publisher|Game publisher|`varchar`|
|developer|Game developer|`varchar`|
|games_sold|Number of copies sold (millions)|`float`|
|year|Release year|`int`|


1. Find the ten best-selling games. The output should contain all the columns in the game_sales table and be sorted by the games_sold column in descending order. Save the output as best_selling_games.

i need MAX(games_sold) with limit 10, and grouped by name to find top selling games
However, i only want to group by name when im required to include non-aggregate columns: platform, publisher, developer. 
So i need to use a CTE to aggregate game_sales by name and MAX(game_sold) without those pesky non-aggregate columns i dont need to group by   
So my main table will JOIN game_sales table to get non-aggregate columns left out of CTE, and the CTE will pipe in aggregate.
USING JOIN, the other columns will only match my aggregate rows 

Attempt 1: 
WITH group_name AS(
    SELECT 
        name,
        MAX(games_sold)
    FROM
        game_sales
    GROUP BY
        name
)


SELECT
    name,
    gs.platform,
    gs.publisher,
    gs.developer,
    gs.games_sold,
    gs.year
FROM 
    game_sales as gs
JOIN
    group_name as gn ON gs.name = gn.name
ORDER BY 
    gs.games_sold DESC

LIMIT 
    10;


Attempt 2: 
Joining by Name wasnt enough. Because it wasnt joining the rows with max(games_sold) from the CTE. 
I have to explicitly join them with the original table to only have those rows using inner join to have the same games sold

WITH group_name AS(
    SELECT 
        name,
        MAX(games_sold) as games_sold
    FROM
        game_sales
    GROUP BY
        name
)


SELECT
    gs.name,
    gs.platform,
    gs.publisher,
    gs.developer,
    gs.games_sold,
    gs.year
FROM 
    game_sales as gs
JOIN
    group_name as gn ON gs.name = gn.name AND gs.games_sold = gn.games_sold

ORDER BY 
    gs.games_sold DESC

LIMIT 
    10;


2. Find the ten years with the highest average critic score, where at least four games were released (to ensure a good sample size). Return an output with the columns year, num_games released, and avg_critic_score. The avg_critic_score should be rounded to 2 decimal places. The table should be ordered by avg_critic_score in descending order. Save the output as critics_top_ten_years. Do not use the critics_avg_year_rating table provided; this has been provided for your third query.
