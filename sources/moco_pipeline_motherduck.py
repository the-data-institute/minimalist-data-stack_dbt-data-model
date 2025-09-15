import dlt
from dlt.sources.rest_api import RESTAPIConfig, rest_api_resources
from datetime import datetime

@dlt.source
def moco_source(api_key=dlt.secrets.value):
    today = datetime.now().strftime("%Y-%m-%d")

    config: RESTAPIConfig = {
        "client": {
            "base_url": "https://thedatainstitute.mocoapp.com/api/v1",
            "auth": {
                "type": "bearer",
                "token": api_key,
            }
        },
        "resource_defaults": {
            "primary_key": "id",
            "write_disposition": "append",
        },
        "resources": [
            {
                "name": "users",
                "write_disposition": "replace",
                "endpoint": {
                    "path": "users",
                }
            },
            {
                "name": "activities",
                "endpoint": {
                    "path": "activities",
                    "params": {
                        "updated_after": "{incremental.start_value}",
                        "from": "2024-04-01",
                        "to": today
                    },
                    "incremental": {
                        "cursor_path": "updated_at",
                        "initial_value": "2024-04-01T00:00:00Z"
                    }
                },
            },
            {
                "name": "invoice_payments",
                "endpoint": {
                    "path": "invoices/payments",
                    "params": {
                        "updated_after": "{incremental.start_value}",
                        "date_from": "2024-04-01",
                        "date_to": today
                    },
                    "incremental": {
                        "cursor_path": "updated_at",
                        "initial_value": "2024-04-01T00:00:00Z"
                    }
                }
            },
            {
                "name": "purchase_budgets",
                "write_disposition": "replace",
                "endpoint": {
                    "path": "purchases/budgets"
                }
            },
            {
                "name": "purchase_payments",
                "endpoint": {
                    "path": "purchases/payments",
                    "params": {
                        "updated_after": "{incremental.start_value}",
                        "date_from": "2024-04-01",
                        "date_to": today
                    },
                    "incremental": {
                        "cursor_path": "updated_at",
                        "initial_value": "2024-04-01T00:00:00Z"
                    }
                }
            },
            {
                "name": "companies",
                "write_disposition": "replace",
                "endpoint": {
                    "path": "companies"
                }
            }
        ]
    }

    yield from rest_api_resources(config)

def load_moco() -> None:
    pipeline = dlt.pipeline(
        pipeline_name="moco-to-motherduck",
        destination="motherduck",
        dataset_name="moco"
    )

    load_info = pipeline.run(moco_source(), loader_file_format="parquet")
    print(load_info)

if __name__ == '__main__':
    load_moco()