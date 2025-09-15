with moco_invoice_payments as (
    select * 
    from {{ source('moco', 'invoice_payments') }}
),

renamed as (
    select
        id as moco_invoice_payment_id,
        cast(date as date) as invoice_payment_date,
        invoice__id as invoice_id,
        invoice__identifier as invoice_number,
        invoice__title as invoice_title,
        paid_total,
        paid_total_in_account_currency,
        currency,
        description,
        created_at,
        updated_at,
        _dlt_load_id,
        _dlt_id
    from moco_invoice_payments
)

select *
from renamed