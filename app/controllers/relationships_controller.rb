class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    #form_tagで送られてきたfollowed_idと一致するユーザーを見つけて、userに代入
    user = User.find(params[:followed_id])
    #現在のユーザーでuserをフォローする
    current_user.follow(user)
    redirect_to user
  end
  
  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
  
end
