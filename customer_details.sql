-- Pattern: LEFT JOIN to preserve primary table.

/*
Steps
1. Left join to fact orders table
2. Order by first_name ASC and order_details ASC
*/
select 
    first_name,
    last_name,
    city,
    order_details
from customers LEFT JOIN orders
    ON customers.id = orders.cust_id
ORDER BY 
    first_name, 
    order_details;
