
with campaigns as (

    select * from {{  ref('stg_campaigns') }}

),

orders as (

    select * from {{ ref('stg_orders')}}
),

campaign_funnel as (
    select 
        c.campaign_id,
        c.campaign_type,
        c.campaign_name,
        c.region,
        c.impressions,
        c.clicks,
        c.channel,
        c.spend_usd,
        c.budget_usd,
        c.budget_utilization_rate,
        count(o.order_id)                as orders_count,
        sum(o.net_revenue_usd)           as revenue,
    
    from campaigns c
    left join orders o on c.campaign_id = o.campaign_id 


    GROUP BY
        c.campaign_id,
        c.campaign_type,
        c.campaign_name,
        c.region,
        c.impressions,
        c.clicks,
        c.channel,
        c.spend_usd,
        c.budget_usd,
        c.budget_utilization_rate
)

select * from campaign_funnel