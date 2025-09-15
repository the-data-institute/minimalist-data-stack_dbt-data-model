with moco_companies_projects as (
    select * 
    from {{ source('moco', 'companies__projects') }}
),

renamed as (
    select 
        id as moco_project_id,
        identifier as project_number,
        name as project_name,
        active as is_active,
        billable as is_billable,
        _dlt_parent_id,
        _dlt_list_idx,
        _dlt_id
    from moco_companies_projects
)

select * 
from renamed