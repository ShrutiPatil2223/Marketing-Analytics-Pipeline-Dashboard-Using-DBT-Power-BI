with source as (
    select * from `marketing-analytics-dbt-497908`.`marketing_raw`.`orders`
),

renamed as (
    select
        order_id,
        customer_id,
        campaign_id,
        cast(order_date as date)    as order_date,
        product,
        quantity,
        unit_price_usd,
        gross_revenue_usd,
        discount_pct,
        net_revenue_usd,
        payment_method,
        order_status
    from source
    where order_status != 'refunded'
    and net_revenue_usd >= 0
)

select * from renamed