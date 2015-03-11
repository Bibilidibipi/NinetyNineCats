# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(name: 'boo', color: 'white', birth_date: 2.days.ago, sex: 'M')
Cat.create!(name: 'meowth', color: 'calico', birth_date: 10.years.ago, sex: 'M')
Cat.create!(name: 'grump', color: 'tabby', birth_date: 5.months.ago, sex: 'F')
Cat.create!(name: 'yelper', color: 'black', birth_date: 100.days.ago, sex: 'F')

Cat.second.requests.create!(start_date: 100.days.from_now, end_date: 180.days.from_now)
Cat.first.requests.create!(start_date: 1.year.from_now, end_date: 2.years.from_now)
Cat.first.requests.create!(start_date: 2.days.from_now, end_date: 4.days.from_now)
