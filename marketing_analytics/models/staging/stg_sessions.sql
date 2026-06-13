with source AS (
    
    SELECT * FROM {{  source('marketing_raw' , 'sessions') }}

) ,

renamed as (
    select 
        session_id,
        customer_id,
        cast(session_date as date)                    as session_date,
        traffic_source,
        device,
        country,
        landing_page,
        pages_viewed,
        round(session_duration_sec / 60.0, 2)         as session_duration_min,
        is_bounce,
        is_converted,
        case
            when traffic_source in ('paid_search', 'paid_social')  then 'paid'
            when traffic_source in ('organic', 'referral')         then 'organic'
            when traffic_source = 'email'                          then 'owned'
            else                                                        'direct'
        end as traffic_category
    from source
)

select * from renamed