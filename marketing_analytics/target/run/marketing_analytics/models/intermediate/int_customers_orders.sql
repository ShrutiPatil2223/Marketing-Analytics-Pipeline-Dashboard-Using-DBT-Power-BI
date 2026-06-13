
  
    

    create or replace table `marketing-analytics-dbt-497908`.`marketing_dev_intermediate`.`int_customers_orders`
      
    
    

    
    OPTIONS()
    as (
      with orders as (
    select * from `marketing-analytics-dbt-497908`.`marketing_dev_staging`.`stg_orders`
),

customers as (
    select * from `marketing-analytics-dbt-497908`.`marketing_dev_staging`.`stg_customers`
),

customer_orders as (

    select 
        c.customer_id,
        count(o.order_id)                                        as total_orders,
        round(sum(o.net_revenue_usd), 2)                         as total_revenue,
        round(avg(o.net_revenue_usd), 2)                         as avg_order_value,
        min(o.order_date)                                        as first_order_date,
        max(o.order_date)                                        as last_order_date,
        date_diff(max(o.order_date), min(o.order_date), day)     as days_between_first_and_last

    from orders o
    left join customers c on o.customer_id = c.customer_id

    group by c.customer_id  -- ← only group by customer!

)

select * from customer_orders
    );
  