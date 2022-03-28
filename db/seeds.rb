<<<<<<< HEAD
User.create!(
  name: "admin",
  email: "admin@gmail.com",
  password: "14062000",
  password_confirmation: "14062000",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)
  99.times do |n|
=======
User.create!(name: "admin",
  email: "admin@gmail.com",
  password: "14062000",
  password_confirmation: "14062000",
  admin: true)
  50.times do |n|
>>>>>>> chapter-10
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
<<<<<<< HEAD
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
=======
  email: email,
  password: password,
  password_confirmation: password)
>>>>>>> chapter-10
end
