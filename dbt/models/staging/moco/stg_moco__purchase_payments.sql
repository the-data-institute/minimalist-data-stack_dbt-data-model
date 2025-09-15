with moco_purchase_payments as (
    select * 
    from {{ source('moco', 'purchase_payments') }}
),

renamed as (
    select
        id as moco_purchase_payment_id,
        cast(date as date) as purchase_payment_date,
        purchase__id as purchase_id,
        purchase__identifier as purchase_number,
        purchase__title as purchase_title,
        total as paid_total,
        currency,
        created_at,
        updated_at,
        _dlt_load_id,
        _dlt_id
    from moco_purchase_payments
)

select *
from renamed