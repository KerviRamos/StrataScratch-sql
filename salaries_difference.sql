/*
Pattern: Top N per group using window function and conditional aggregation.

Steps:
1. Join both tables, then filter for dep of interest
2. Use a window function to Find the highest salary per department of interest
3. Take the differences 
*/

WITH base AS(
    select 
        e.id,
        d.department,
        e.salary,
        DENSE_RANK() OVER(PARTITION BY d.department ORDER BY e.salary DESC) AS rnk
    from db_employee AS e INNER JOIN db_dept AS d
        ON e.department_id = d.id
    WHERE d.department IN ('marketing', 'engineering')

)
SELECT
    ABS(SUM(
        CASE 
            WHEN department = 'marketing' THEN (-1*salary) 
            ELSE salary
        END
    )) AS salary_difference
FROM base
WHERE rnk = 1
