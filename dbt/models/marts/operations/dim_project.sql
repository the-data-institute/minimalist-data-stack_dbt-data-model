with staging_moco_projects as (
    select * 
    from {{ ref('stg_moco__companies_projects') }}
),

final as (
    select
        -- primary key
        moco_project_id as project_id,
        
        -- attributes
        project_number,
        project_name,
        is_active,
        is_billable,

        -- meta
        _dlt_id,
        _dlt_parent_id

    from staging_moco_projects
)

select * 
from final