

  create or replace view `marketing-analytics-dbt-497908`.`marketing_dev`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `marketing-analytics-dbt-497908`.`marketing_dev`.`my_first_dbt_model`
where id = 1;

