# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# users
User.create!(user_name: "JohnSally", password_digest: BCrypt::Password.create("happiness"))
User.create!(user_name: "SallyJohn", password_digest: BCrypt::Password.create("sadness"))

# cats
Cat.create!(name: 'boo', color: 'white', birth_date: 2.days.ago, sex: 'M', user_id: 1)
Cat.create!(name: 'meowth', color: 'calico', birth_date: 10.years.ago, sex: 'M', user_id: 2)
Cat.create!(name: 'grump', color: 'tabby', birth_date: 5.months.ago, sex: 'F', user_id: 2)
Cat.create!(name: 'yelper', color: 'black', birth_date: 100.days.ago, sex: 'F', user_id: 2)

# rental requests
Cat.second.requests.create!(start_date: 100.days.from_now,
                            end_date: 180.days.from_now, user_id: 1)
Cat.first.requests.create!(start_date: 1.year.from_now,
                            end_date: 2.years.from_now, user_id: 2)
Cat.first.requests.create!(start_date: 2.days.from_now,
                           end_date: 4.days.from_now, user_id: 2)
