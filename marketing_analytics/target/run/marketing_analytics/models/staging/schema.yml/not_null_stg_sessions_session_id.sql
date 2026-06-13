
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select session_id
from `marketing-analytics-dbt-497908`.`marketing_dev_staging`.`stg_sessions`
where session_id is null



  
  
      
    ) dbt_internal_test