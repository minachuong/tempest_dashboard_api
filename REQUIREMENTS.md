# Full Stack - Ruby - Technical Exercise

The intent of this exercise is to give you an opportunity to prepare a small proof-of-concept application that implements the expected behavior.

You should spend no more than a few hours on this exercise.

After you return your solution to this exercise, we will schedule a follow-up call with you to walk through your solution and pair with you, as we would with our own team members.

Between the exercise and the pairing session, you'll be assessed on the following criteria:
* How well did you follow the instructions in this document?
* How readable is your code to other engineers?
* How clean is your code and your submission?
* How well do you work with peers who are sharing feedback and recommendations?
* How well did you reason about your solution?

We're not looking for the most clever solution or the most perfect solution; we're looking for how you thought through your solution, how you work with the team, and how well on the path to merge-ready code your solution is (and treat it as such - as if the solution you return to us is what you would put up for a pull request in GitHub).

## Included Data

Two sets of data are included that represent 30 days of impressions, conversions, and revenue, as well as the user information associated with the activity.

`users.json`

This file contains an array of users. Each user has an id, name, avatar, and occupation.

`event_data.json`

This file contains event data. Each item has a type (either 'impression' or 'conversion'), date and time of the event, user ID of the associated user, and revenue.

## Requirements

* Prepare a small Ruby on Rails backend application that includes a small database (such as SQLite via Active Record).
* Create a method of loading all the JSON data into the database.
* Write a frontend application that implements the included mock-up in the framework of your choice, using any libraries that are appropriate. The provided mockup is just a guide. Feel free to improve the design within the following requirements:
  * Each card should have the user's avatar, name, and occupation.
  * Each card should display the sum of all impressions, conversions, and revenue.
  * Each card should display a simple chart of conversions per day.
* The data that drives this frontend application should come from the Rails backend and database, not from the JSON data.
* The entire solution should be self-contained and runnable from scratch by members of the Tempest team, once you return your solution (include any shell scripts, rake tasks, list of commands to run - whatever it takes for someone to spin everything up and inspect the running applications, in addition to the code).