# Insights Dashboard API

This API serves as a data source to get insight summary information for users.

## Dependencies 
Please follow instructions on [http://www.installrails.com/](http://www.installrails.com/) for installing Ruby on Rails onto your machine.

## Set Up
Once Rails is completely installed onto your machine:
- `bundle install` to get all required gems
- `rails db:reset` to create, migrate, and seed
- `rails s` to serve the API

### General Payload Notes
- All dates from payloads are in ISO-8601 date format in UTC

## GET /insights/summaries
- Use case: data to user profile and aggregate data (e.g. total revenue, total conversions, total impressions over all of time)
- No Auth Required
- Does not support pagination, you get ALL of it
- Each insight is specific to a user and their metric events
- `date_start` and `date_end` are first and last dates when a user made a conversion
- A 200OK JSON payload looks like this:
```
[
  {
    user: {
      id: 0,
      first_name: "",
      last_name: "",
      occupation: "",
      avatar_url: ""
    }
    total_impressions: 0,
    total_revenue: 0,
    total_conversions: 0,
    date_start: "",
    date_end: ""
  },
  ...
]
```

## GET /insights/dailyconversions?userId={user_id}
- Use case: data that reflects total daily conversions by date by user
- Supports filtering for one user
- No Auth Required
- Does not support pagination, you get ALL of it
- `daily_conversions` is the total number of conversions that a user made with the associated date
- This payload does not include dates where the user made no conversions
- Date has no timezone (so it's defaulting to UTC)! :D
- If user in filter does not exist or the user does not have any conversions, a response of 200OK with `[]` will be given.
- A 200OK JSON payload looks like this:
```
[
  { 
    user_id: 0,
    conversions: [  
      {
        daily_conversions: 0,
        date: ""
      },
      ...
    ]
  },
  ...
]
```
## Deployment
Deployed with Heroku: [https://tempest-dashboard-api.herokuapp.com](https://tempest-dashboard-api.herokuapp.com)

## Tasks
- X build db schema
- X implement seed script
- X design/implement endpoints
- X write spec for endpoints
- X Documentation


### Many thanks to:
- konbert.com

