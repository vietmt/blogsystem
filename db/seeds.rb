# User
User.create!(name:  "VietMT",
             email: "v@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Entry
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(20)
  users.each { |user| user.entries.create!(title: title, content: content) }
end

# Comment 
entries = Entry.order(:created_at).take(6)
50.times do
	content = Faker::Lorem.sentence(3)
	entries.each {|entry| entry.comments.create!(content: content, user_id: entry.user_id)}
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
