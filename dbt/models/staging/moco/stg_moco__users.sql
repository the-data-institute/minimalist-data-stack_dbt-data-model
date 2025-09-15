with moco_users as (
    select * 
    from {{ source('moco', 'users') }}
),

renamed as (
    select
        id as moco_user_id,
        firstname as first_name,
        lastname as last_name,
        active as is_active,
        extern as is_external,
        email,
        mobile_phone,
        work_phone,
        home_address,
        info,
        cast(birthday as date) as birthday,
        iban,
        custom_properties__personalnummer as employee_number,
        unit__id as company_unit_id,
        unit__name as company_unit_name,
        created_at,
        updated_at,
        _dlt_load_id,
        _dlt_id
    from moco_users
)

select * 
from renamed