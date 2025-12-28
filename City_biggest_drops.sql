-- Pattern: Pivoted Conditional Aggregation
-- Steps:
-- 1. Join to get the city name and filter for the target ds
-- 2. aggregate amount per city and calculate the difference between target ds
-- 3. window to find the smallest and largest
WITH base AS(
select 
    b.name,
    DATE(a.order_timestamp_utc) AS order_ds,
    SUM(a.amount) AS tot_amount
from postmates_orders AS a INNER JOIN postmates_markets AS b
    ON a.city_id = b.id
WHERE DATE(a.order_timestamp_utc) IN('2019-03-11','2019-04-11')
GROUP BY 1, 2
), transform AS(
SELECT
    name AS city,
    MAX(CASE WHEN order_ds = '2019-04-11' THEN tot_amount ELSE 0 END) - MAX(CASE WHEN order_ds = '2019-03-11' THEN tot_amount ELSE 0 END) AS diff
FROM base
GROUP BY name
), final AS(
select
    city,
    diff,
    MAX(diff) OVER() AS mx_diff,
    MIN(diff) OVER() AS mn_diff
from transform 
)
select 
    city, 
    diff 
from final 
where diff = mx_diff or diff = mn_diff
