class FollowersController < ApplicationController
  def show
    @title = t ".title"
    @user = User.find_by id: params[:id]
    @pagy, @users = pagy @user.followers.paginate page: params[:page]
    render "show"
  end
end
