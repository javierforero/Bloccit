module UsersHelper
  def does_user_have_post_or_comments?(user)
    unless  user.posts.count + user.comments.count == 0
      true
    end
  end
end
