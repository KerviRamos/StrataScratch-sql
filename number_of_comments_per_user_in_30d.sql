/*
Pattern: Rolling Time window aggreagation

Steps:
1. Filter for created_ at <= 2020-02-10 and
   ensure that the datediff is between 0 to 30
2. aggreagate the num_comments per users in the last 30 days

*/

select 
    user_id,
    sum(number_of_comments) AS tot_num_comments 
from fb_comments_count
where created_at <= '2020-02-10'
      and datediff('2020-02-10', created_at) between 0 and 30
group by 1
