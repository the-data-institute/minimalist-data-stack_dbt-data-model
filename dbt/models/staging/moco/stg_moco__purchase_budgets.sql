with moco_purchase_budgets as (
    select * 
    from {{ source('moco', 'purchase_budgets') }}
),

renamed as (
    select
        id as moco_purchase_budget_id,
        year as purchase_budget_year,
        title,
        active as is_active,
        target as budget_target,
        exhaused as budget_exhausted,
        planned as budget_planned,
        remaining as budget_remaining,
        _dlt_load_id,
        _dlt_id
    from moco_purchase_budgets
)

select *
from renamed