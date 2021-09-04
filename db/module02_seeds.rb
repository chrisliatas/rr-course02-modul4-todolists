# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Profile.destroy_all
User.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

Profile.create! [
  { first_name: "Carly",   last_name: "Fiorina", birth_year: 1954, gender: "female" },
  { first_name: "Donald",  last_name: "Trump",   birth_year: 1946, gender: "male" },
  { first_name: "Ben",     last_name: "Carson",  birth_year: 1951, gender: "male" },
  { first_name: "Hillary", last_name: "Clinton", birth_year: 1947, gender: "female" }
]

pall = Profile.all
pall.each do |p|
  p.create_user( username: p.last_name, password_digest: rand(10 ** 10) )
  p.user.todo_lists.create! [ list_name: p.first_name + "list", list_due_date: Date.today + 1.year ]
end

tlists = TodoList.all
tlists.each do |tl|
  5.times do
    tl.todo_items.create! [ due_date: Date.today + 1.year, title: (0...8).map { (65 + rand(26)).chr }.join, description: (0...50).map { ('a'..'z').to_a[rand(26)] }.join  ]
  end
end
