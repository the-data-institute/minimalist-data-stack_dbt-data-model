with moco_companies_tags as (
    select * 
    from {{ source('moco', 'companies__labels') }}
),

renamed as (
    select 
        value as label_name,
        _dlt_parent_id,
        _dlt_list_idx,
        _dlt_id
    from moco_companies_tags
)

select * 
from renamed