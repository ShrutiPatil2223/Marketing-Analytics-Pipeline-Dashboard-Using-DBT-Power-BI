with source as (
    select * from `marketing-analytics-dbt-497908`.`marketing_raw`.`campaigns`
),

renamed as (
    select
        campaign_id,
        campaign_name,
        channel,
        case
            when channel in ('Paid Search', 'Paid Social', 'Display')  then 'Paid'
            when channel in ('SEO', 'Content')                         then 'Organic'
            when channel in ('Email', 'Webinar', 'Event')              then 'Owned'
            else 'Other'   
        end as channel_category, -- what about other category??
       
        campaign_type,
        region,
        cast(start_date as date)                           as start_date,
        cast(end_date as date)                             as end_date,
        date_diff(cast(end_date as date),
                  cast(start_date as date), day)           as campaign_duration_days,
        budget_usd,
        spend_usd,
        round(safe_divide(spend_usd, budget_usd), 4)      as budget_utilization_rate,
        impressions,
        clicks,
        leads_generated,
        conversions
    from source
)

select * from renamed