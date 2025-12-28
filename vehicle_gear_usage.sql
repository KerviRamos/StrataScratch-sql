-- Pattern: Event-to-Event Duration Using Window Functions
-- Steps:
-- 1. Lead window to get state end time
-- 2. take the difference and compute timespent
-- 3. aggregate to compute the total timespent in hrs
WITH base AS(
select 
    car_id,
    gear,
    COALESCE(LEAD(timestamp_epoch) OVER(PARTITION BY car_id ORDER BY timestamp_epoch ASC) - timestamp_epoch
    ,7200
    ) AS t_delta
from vehicle_telemetry
)
SELECT
    gear,
    SUM(t_delta)/3600.00 AS total_hours
FROM base
GROUP BY gear
