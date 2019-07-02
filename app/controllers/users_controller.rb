class UsersController < ApplicationController
  before_action :logged_in_user,only: [:edit,:update,:destroy]
  before_action :correct_user,only: [:edit,:update,:destroy]
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = "ログインに成功しました！"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "編集が完了しました！"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "削除に成功しました"
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:picture)
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:notice] = "ログインしてください"
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:notice] = "自分以外のユーザー情報は変更・削除できません"
      redirect_to root_url
    end
  end
  
  
end
