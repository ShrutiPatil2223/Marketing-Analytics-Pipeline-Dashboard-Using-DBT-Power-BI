
  
    

    create or replace table `marketing-analytics-dbt-497908`.`marketing_dev_intermediate`.`int_customers_sessions`
      
    
    

    
    OPTIONS()
    as (
      with sessions as (
        
        select * from `marketing-analytics-dbt-497908`.`marketing_dev_staging`.`stg_sessions` 
    ),

    customers as (
        select * from `marketing-analytics-dbt-497908`.`marketing_dev_staging`.`stg_customers`
    ),


    customers_sessions as(
        select 
            c.customer_id,
            c.full_name,
            c.segment,
            c.industry,
            c.country,
            c.acquisition_channel,    
            c.acquisition_category,
            count(s.session_id)                    as total_sessions,
            sum(s.pages_viewed)                      as total_pages,
            round(avg(s.session_duration_min),2)              as avg_session_duration,
            round(avg(case when s.is_bounce then 1.0 else 0 end), 4 )  as bounce_rate,
            countif(s.is_converted = TRUE)                as web_conversion_count
        from customers c
        left JOIN sessions s on c.customer_id = s.customer_id

        GROUP BY
            c.customer_id,
            c.full_name,
            c.segment,
            c.industry,
            c.country,
            c.acquisition_channel,    
            c.acquisition_category          
    )

    select * from customers_sessions
    );
  