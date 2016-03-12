require 'random_data'

50.times do

  Post.create!(
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


puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
