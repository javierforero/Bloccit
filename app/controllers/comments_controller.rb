class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    comment = commentable.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to :back
    else
      flash[:alert] = "Comments failed to save"
      redirect_to :back
    end
  end

  def destroy
    comment = commentable.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to :back
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to :back
    end
  end

  private

  def commentable
    @commentable ||= \
      if params[:post_id].present?
        Post.find(params[:post_id])
      elsif params[:topic_id].present?
        Topic.find(params[:topic_id])
      else
        fail 'Must provide topic or post id'
      end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to :back
    end
  end

end
