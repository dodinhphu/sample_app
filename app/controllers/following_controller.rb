class FollowingController < ApplicationController
  def show
    @title = t ".title"
    @user = User.find_by id: params[:id]
    @pagy, @users = pagy @user.following.paginate page: params[:page]
  end
end
