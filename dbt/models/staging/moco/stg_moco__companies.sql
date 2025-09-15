with moco_companies as (
    select * 
    from {{ source('moco', 'companies') }}
),

renamed as (
    select 
        id as moco_company_id,
        type as company_type,
        name as company_name,
        website as website,
        email,
        country_code,
        identifier as customer_number,
        intern as is_internal,
        created_at,
        updated_at,
        _dlt_load_id,
        _dlt_id
    from moco_companies
)

select * 
from renamed