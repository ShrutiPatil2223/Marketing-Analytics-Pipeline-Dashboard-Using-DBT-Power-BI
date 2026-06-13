with orders as (

    select * from {{ ref('stg_orders') }}
),

campaign_funnel as (

    select * from {{ ref('int_campaign_funnel') }}
),

channel_monthly as (
    select 
        date_trunc(o.order_date, month)     as month,
        cf.channel,
        sum(o.net_revenue_usd)              as total_revenue,
        sum(cf.spend_usd)                   as total_spend

    from orders o
    left join  campaign_funnel cf on o.campaign_id = cf.campaign_id -- it says use inner join , why?because of the channels pie chart - green one should come as the "other" category
    GROUP BY
        date_trunc(o.order_date, month),
        cf.channel

)

select * from channel_monthly