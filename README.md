# Dashboard API

## GET /insights
- No Auth Required
- Does not support pagination, you get ALL of it
- Each insight is specific to a user and their metrics

```
[
  {
    first_name: "",
    middle_name: "",
    last_name: "",
    occupation: "",
    total_impressions: 0,
    total_revenue: 0,
    conversions: {
      total: 0,
      date_start: "",
      date_end: ""
    }
  },
  ...
]
```


## Seed Data
Used konbert.com to convert json into sql for event data --> Metric Event (there were conflicts created with trying to create an Event class)
created_at and updated_at used time as source for these columns


