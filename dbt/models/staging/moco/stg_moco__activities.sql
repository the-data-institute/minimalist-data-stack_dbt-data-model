with moco_activities as (
    select * 
    from {{ source('moco', 'activities') }}
),

renamed as (
    select 
        id as moco_activity_id,
        cast(date as date) as activity_date,
        hours as hours_spent,
        description,
        billable as is_billable,
        billed as is_billed,
        tag,
        remote_service,
        project__id as project_id,
        project__name as project_name,
        project__billable as is_project_billable,
        task__id as task_id,
        task__name as task_name,
        task__billable as is_task_billable,
        customer__id as customer_id,
        customer__name as customer_name,
        user__id as moco_user_id,
        created_at,
        updated_at,
        hourly_rate,
        seconds as seconds_spent,
        _dlt_load_id,
        _dlt_id,
        invoice_id
    from moco_activities
)

select * 
from renamed