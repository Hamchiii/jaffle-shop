with

orders as (

    select c.customer_name, o.ordered_at, o.order_total
    from {{ ref('stg_orders') }} o 
    join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id
    where order_total > 100

)

select * from orders
