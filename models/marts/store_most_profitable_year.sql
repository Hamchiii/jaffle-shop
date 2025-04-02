with sales_by_year as (
    select
        l.location_id,
        l.location_name as location,
        extract(year from o.ordered_at) as order_year,
        sum(o.order_total) as total_sales
    from {{ ref('orders') }} o
    join {{ ref('stg_locations') }} l
      on o.location_id = l.location_id
    group by l.location_id, l.location_name, extract(year from o.ordered_at)
),

ranked_sales as (
    select
        location_id,
        location,
        order_year,
        total_sales,
        row_number() over (partition by location_id order by total_sales desc) as rn
    from sales_by_year
)
select
    location_id,
    location,
    order_year as most_profitable_year,
    total_sales as highest_sales
from ranked_sales
where rn = 1