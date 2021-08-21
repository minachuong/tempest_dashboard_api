require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# create users from json source
def load_users
  user_file = File.read('./db/users.json')
  user_data = JSON.parse(user_file)

  sorted_user_data = user_data.sort {|a,b| a["id"] <=> b["id"]}

  users = sorted_user_data.each_with_index { |user, index| 
    first_name, last_name = user["name"].split(" ", 2)

    User.create!(
      first_name: first_name,
      last_name: last_name,
      avatar_url: user["avatar"],
      occupation: user["occupation"],
    )
    # p user["id"] == index + 1 # simple test to ensure the source data did not skip user id's
  }
end

load_users
p "user data loaded!"

def execute_sql_file(path, connection = ActiveRecord::Base.connection)
  sql = IO.read(path)
  connection.execute(sql)
end

p "loading metric event data ..."
execute_sql_file('./db/event_data_load_01.sql')
p "metric event data loaded!"





