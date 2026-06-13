
  
    

    create or replace table `marketing-analytics-dbt-497908`.`marketing_dev_marts`.`mart_campaign_performance`
      
    
    

    
    OPTIONS()
    as (
      with campaign_funnel as (
    select * from `marketing-analytics-dbt-497908`.`marketing_dev_intermediate`.`int_campaign_funnel`
),

campaign_performance as (

    select 
        campaign_id,
        campaign_type,
        campaign_name,
        region,
        impressions,
        clicks,
        channel,
        spend_usd,
        budget_usd,
        budget_utilization_rate,
        orders_count,
        revenue,
        round (safe_divide (clicks , impressions),2) as ctr,
        round (safe_divide (revenue , spend_usd),2) as roas,
        round (safe_divide (revenue - spend_usd ,  spend_usd ) * 100 ,2) as roi_pct

from campaign_funnel
)

select * from campaign_performance
    );
  