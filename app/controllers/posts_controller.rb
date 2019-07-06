class PostsController < ApplicationController
  before_action :logged_in_user,only:[:create,:destroy]
  before_action :correct_user,only: :destroy
  
  def create
    #users/showページのフォームから送られた内容を取得する
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました！"
      redirect_to user_path(current_user)
    else
      render 'top/index'
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = "削除に成功しました！"
    redirect_to request.referrer || root_url
  end
  
  def index
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content,:picture)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
