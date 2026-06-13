with source AS (
    
    SELECT * FROM  `marketing-analytics-dbt-497908`.`marketing_raw`.`customers`
        
    ), 

renamed as (

    SELECT 
        customer_id,
        first_name,
        last_name,
        first_name || '' || last_name as full_name,
        lower(email) as email,
        segment,
        industry,
        upper(country) as country,
        acquisition_channel,
        case
            when acquisition_channel in ('Paid Search', 'Paid Social')           then 'Paid'
            when acquisition_channel in ('Organic Search', 'Email Referral')     then 'Organic'
            when acquisition_channel in ('Webinar', 'Event')                     then 'Owned'
            else                                                                       'Direct'
        end as acquisition_category,
        
        cast (created_at as date )   as created_at ,
        is_active

    FROM source

)

select * from renamed