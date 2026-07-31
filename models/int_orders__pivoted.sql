{% set pm = ['bank_transfer', 'credit_card', 'coupon', 'gift_card']%}
with payments as (

    select * from {{ ref('stg_stripe__payments') }} where status = 'success'

), pivoted as (
    select 
        order_id,
        {% for i in pm %}
            sum( case when paymentmethod = '{{ i }}' then amount else 0 end ) as {{ i }}
            {% if not loop.last %}
                ,
            {% endif %}
        {% endfor %}
        from payments
        group by 1
)

select * from pivoted