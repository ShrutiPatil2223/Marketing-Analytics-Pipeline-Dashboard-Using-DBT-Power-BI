with customers as (

    select *
    from {{ ref('stg_customers') }}

),

customer_orders as (

    select *
    from {{ ref('int_customers_orders') }}

),

customer_sessions as (

    select *
    from {{ ref('int_customers_sessions') }}

),

customer_journey as (

    select
        c.customer_id,
        c.full_name,
        c.segment,
        c.industry,
        c.country,
        c.acquisition_channel,
        c.acquisition_category,
        c.created_at,

        cs.total_sessions,
        cs.total_pages,
        cs.avg_session_duration,
        cs.bounce_rate,
        cs.web_conversion_count,

        co.total_orders,
        co.total_revenue,
        co.avg_order_value,
        co.first_order_date,
        co.last_order_date,

        -- Customer Lifetime Value
        co.total_revenue as customer_lifetime_value,

        -- Days to first purchase
        date_diff(co.first_order_date, c.created_at, day) as days_to_first_purchase,

        -- Session to order conversion
        safe_divide(co.total_orders , cs.total_sessions) as session_to_order_rate,

        -- Pages viewed per session
        safe_divide(cs.total_pages , cs.total_sessions) as avg_pages_per_session,

        -- Days since last order
        date_diff(current_date(), co.last_order_date, day) as days_since_last_order,

        -- RFM Recency
        case
            when date_diff(current_date(), co.last_order_date, day) <=100 then 5
            when date_diff(current_date(), co.last_order_date, day) <= 200 then 4
            when date_diff(current_date(), co.last_order_date, day) <= 400 then 3
            when date_diff(current_date(), co.last_order_date, day) <= 600 then 2
            else 1
        end as recency_score,

        -- RFM Frequency
        case
            when co.total_orders >= 7 then 5
            when co.total_orders >= 5 then 4
            when co.total_orders >= 3 then 3
            when co.total_orders >= 2 then 2
            else 1
        end as frequency_score,

        -- RFM Monetary
        case
            when co.total_revenue >= 5000 then 5
            when co.total_revenue >= 3000 then 4
            when co.total_revenue >= 1500 then 3
            when co.total_revenue >= 500 then 2
            else 1
        end as monetary_score

    from customers c

    left join customer_orders co
        on c.customer_id = co.customer_id

    left join customer_sessions cs
        on c.customer_id = cs.customer_id

)

select *
from customer_journey