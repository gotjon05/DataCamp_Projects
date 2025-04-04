




/*
| Column | Definition | Data Type |
|-|-|-|
|country_name|Name of the country|`varchar`|
|country_code|Code representing the country|`varchar`|
|indicator_name|Description of the debt indicator|`varchar`|
|indicator_code|Code representing the debt indicator|`varchar`|
|debt|Value of the debt indicator for the given country (in current US dollars)|`float`|

1. What is the number of distinct countries present in the database? The output should be single row and column aliased as total_distinct_countries. Save the query as num_distinct_countries.

I need to use Distinct to avoid counting duplicates
Single row and column with aggregate count of distinct country codes
*/
SELECT 
    COUNT(Distinct(country_code)) AS total_distinct_countries
FROM 
    international_debt

/*
2. What country has the highest amount of debt? Your output should contain two columns: country_name and total_debt and one row. Save the query as highest_debt_country.

i need to group by dimension column, country_name in order to calculate the aggegrate column, the sum of total debt

*/
-- highest_debt_country 
-- Write your query here... 
SELECT 
	country_name,
    SUM(debt) AS total_debt
    
FROM
    international_debt
GROUP by 
    country_name
ORDER BY
	total_debt DESC
LIMIT
	1;

/*
3.What country has the lowest amount of principal repayments (indicated by the "DT.AMT.DLXF.CD" indicator code)? The output table should contain three columns: country_name, indicator_name, and lowest_repayment and one row, saved in the query lowest_principal_repayment.

confused by lowest_repayment being a required column -- didnt make that connection with debt -- lowest repayment, highest debt
*/

-- lowest_principal_repayment 
-- Write your query here... 
SELECT
    country_name,
	indicator_name,
	debt AS lowest_repayment
FROM
    international_debt
WHERE
    indicator_code = 'DT.AMT.DLXF.CD'
ORDER BY
	debt ASC
LIMIT 1;