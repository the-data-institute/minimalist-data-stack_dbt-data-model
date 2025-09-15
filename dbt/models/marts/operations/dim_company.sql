with staging_moco_companies as (
    select * 
    from {{ ref('stg_moco__companies') }}
),

final as (
    select
        -- primary key
        moco_company_id as company_id,

        -- attributes
        company_type,
        company_name,
        website,
        email,
        country_code,
        customer_number,
        is_internal,
        
        -- meta
        created_at,
        updated_at,
        _dlt_load_id,
        _dlt_id
    
    from staging_moco_companies
)

select * 
from final