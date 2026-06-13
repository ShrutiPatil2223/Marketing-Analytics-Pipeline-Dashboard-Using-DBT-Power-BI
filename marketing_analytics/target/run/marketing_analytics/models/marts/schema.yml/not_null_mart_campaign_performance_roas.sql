
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select roas
from `marketing-analytics-dbt-497908`.`marketing_dev_marts`.`mart_campaign_performance`
where roas is null



  
  
      
    ) dbt_internal_test