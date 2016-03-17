require 'random_data'

15.times do
  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )
end
topics = Topic.all
50.times do

  Post.create!(
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

#unique post
 unique_post = Post.find_or_create_by(title: "Unique Post", body:  "I am an unique post")
#unique comment tied to unique post
 unique_post.comments.find_or_create_by(
    body: "I am a comment in the unique post"
  )

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
puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
