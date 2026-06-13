
    
    

with dbt_test__target as (

  select campaign_id as unique_field
  from `marketing-analytics-dbt-497908`.`marketing_dev_marts`.`mart_campaign_performance`
  where campaign_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


