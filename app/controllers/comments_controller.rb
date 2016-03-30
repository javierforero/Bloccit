class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  before_action :is_commentable_post?
  def create

      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user

    if @comment.save && is_commentable_post?
      flash[:notice] = "Comment saved successfully."
      redirect_to topic_post_path(@commentable, @commentable)
    elsif @comment.save && !is_commentable_post?
      flash[:notice] = "Comment saved successfully."
      redirect_to @commentable
    elsif is_commentable_post?
      flash[:alert] = "Comments failed to save"
      redirect_to topic_post_path(@commentable, @commentable)
    else
      flash[:alert] = "Comments failed to save"
      redirect_to @commentable
    end
  end

  def destroy

      @comment = @commentable.comments.find(params[:id])

    if @comment.destroy && is_commentable_post?

      flash[:notice] = "Comment was deleted."
      redirect_to topic_post_path(@commentable, @commentable)
    elsif @comment.destroy && !is_commentable_post?
      flash[:notice] = "Comment was deleted."
      redirect_to @commentable
    elsif is_commentable_post?
      flash[:alert] = "Comments failed to save"
      redirect_to topic_post_path(@commentable, @commentable)
    else
      flash[:alert] = "Comments failed to save"
      redirect_to @commentable
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
 def is_commentable_post?
   @commentable.class == Post
 end
end
