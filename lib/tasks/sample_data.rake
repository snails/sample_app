namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    user = User.create!(name: "David Wei",
                        email: "godhuyang@gmail.com",
                        password: "123456",
                        password_confirmation: "123456")
    user.toggle!(:admin)
    99.times do |n|
    
      name  = Faker::Name.name
      email = "9057321#{n+1}@qq.com"
      password = "password"
      User.create!(name: name,
      email: email,
      password: password,
      password_confirmation: password)
    end

    users = User.find_by_email("godhuyang@gmail.com")
    50.times do
      content = Faker::Lorem.sentence(5)
       users.microposts.create!(content: content)
    end
  end
end
