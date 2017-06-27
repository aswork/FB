# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |n|
     name = Faker::Name.name
     email = Faker::Internet.email
     password = Faker::Internet.password
     uid = SecureRandom.uuid
     avatar = Faker::Avatar.image

     user = User.new(name: name,
                     email: email,
                     uid: uid,
                     avatar: avatar,
                     password: password,
                     password_confirmation: password,
                      )
     user.skip_confirmation!
     user.save(validate: false)
     end


10.times do |i|
   @topic = Topic.create(title: "テスト",content: "テスト",user_id: 1+i)
10.times do
   @topic.comments.build(content: 'テスト',user_id: 1+i)
   end
  @topic.save
  end
