class LikesController < ApplicationController
  
  
  def create
    @post = Post.find_by(id: params[:id])
    @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    if @like.save
      redirect_to current_user
    end
  end
  
  def destroy
    @like= Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to current_user
  end
  
  
  private
  
  def like_params
    params.require(:like).permit(:user_id,:post_id)
  end
  
end
