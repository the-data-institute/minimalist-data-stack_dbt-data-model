{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'delete+insert',
        unique_key = 'activity_id'
    )
}}

with staging_moco_activities as (
    select *
    from {{ ref('stg_moco__activities') }}
    where 1 = 1
        {% if is_incremental() %}
            and _dlt_load_id > (select max(_dlt_load_id) from {{ this }})
        {% endif %}
),

final as (
    select
        -- primary and foreign keys
        moco_activity_id as activity_id,
        project_id,
        customer_id as company_id,
        moco_user_id as employee_id,
        activity_date, 

        -- metrics
        hours_spent,

        -- meta
        created_at,
        updated_at,
        _dlt_load_id
    from staging_moco_activities
)

select * 
from final