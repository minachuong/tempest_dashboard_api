require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# create users from json source
user_file = File.read('./db/users.json')
user_data = JSON.parse(user_file)

users = user_data.map { |user| 
  full_name = user["name"].split(/ /, 2)

  User.create!(first_name: full_name[0],
    last_name: full_name[1],
    avatar_url: user["avatar"],
    occupation: user["occupation"],
    source_id: user["id"])
}

