-- PATTERN: Dedup before windowing
/* 
Steps:
1. Canonicalize the table
2. Use lag window func to calculate the change in prices
*/
WITH dedup AS(
    SELECT DISTINCT
        car_part_id,
        model_year, 
        price
    FROM car_parts
)
select 
    car_part_id,
    model_year,
    price,
    price - LAG(price) OVER(PARTITION BY car_part_id ORDER BY model_year ASC) AS price_change
from dedup
ORDER BY 1, 2
