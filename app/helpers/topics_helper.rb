module TopicsHelper
  def user_is_authorized_for_topics?
       current_user && current_user.admin? && !current_user.moderator?
  end

  def user_is_authorized_for_edit?
      current_user.moderator?
  end
end