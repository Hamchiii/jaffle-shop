with

customers as (

    select * from {{ ref('customers') }}

),

orders as (

    select customer_id, count(order_id) as nb_orders, sum(order_total) as total_spent
    from {{ ref('orders') }}
    group by customer_id
)

select c.customer_name, c.customer_type, o.nb_orders, o.total_spent
from customers c
left join orders as o 
on c.customer_id = o.customer_id