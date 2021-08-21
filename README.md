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



