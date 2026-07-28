with customers as (

   select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

payments as (

    select * from {{ ref('stg_stripe__payments') }}

),

final as (
    select orders.order_id,
    customers.customer_id,
    payments.amount
    from orders
    left join customers using (customer_id)
    left join payments using (order_id)
)
select * from final