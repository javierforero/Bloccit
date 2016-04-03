class FavoritesController < ApplicationController
   before_action :require_sign_in
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Post was favorite"
    else
      flash[:alert] = "ooops your post wasnt saved.Try again!"
    end
    redirect_to [post.topic, post]
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Post was unfavorited"
    else
      flash[:alert] = "You post wasn't unfavorited"
    end

    redirect_to [post.topic, post]
  end
end
