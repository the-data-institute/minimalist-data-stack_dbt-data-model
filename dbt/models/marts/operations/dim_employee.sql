with staging_moco_users as (
    select * 
    from {{ ref('stg_moco__users') }}
),

final as (
    select
        -- primary key
        moco_user_id as employee_id,
        
        -- attributes
        employee_number,
        first_name,
        last_name,
        email,
        birthday,
        mobile_phone,
        work_phone,
        home_address,
        company_unit_id,
        company_unit_name

        -- meta
        created_at,
        updated_at,
        _dlt_load_id,
        _dlt_id
    from staging_moco_users
    where is_external = 0
)

select * 
from final