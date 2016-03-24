require 'random_data'

5.times do
  User.create!(

  name:     RandomData.random_name,
  email:    RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all


15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

50.times do

  Post.create!(
  user:  users.sample,
  topic: topics.sample,
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

50.times do Advertisement.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph,
  price: RandomData.random_price
  )
end

50.times do Question.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph,
  resolved: false
  )
end

user = User.first
user.update_attributes!(
  email: 'javierforero01@gmail.com',
  password: '12345Tri'
)

#unique post
 # unique_post = Post.find_or_create_by(title: "Unique Post", body:  "I am an unique post", user: user)
 # unique_post.comments.find_or_create_by(
 #    body: "I am a comment in the unique post"
 #  )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
