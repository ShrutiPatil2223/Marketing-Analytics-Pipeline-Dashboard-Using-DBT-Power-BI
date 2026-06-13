
  
    

    create or replace table `marketing-analytics-dbt-497908`.`marketing_dev_marts`.`mart_channel_monthly`
      
    
    

    
    OPTIONS()
    as (
      with orders as (

    select * from `marketing-analytics-dbt-497908`.`marketing_dev_staging`.`stg_orders`
),

campaign_funnel as (

    select * from `marketing-analytics-dbt-497908`.`marketing_dev_intermediate`.`int_campaign_funnel`
),

channel_monthly as (
    select 
        date_trunc(o.order_date, month)     as month,
        cf.channel,
        sum(o.net_revenue_usd)              as total_revenue,
        sum(cf.spend_usd)                   as total_spend

    from orders o
    left join  campaign_funnel cf on o.campaign_id = cf.campaign_id
    GROUP BY
        date_trunc(o.order_date, month),
        cf.channel

)

select * from channel_monthly
    );
  