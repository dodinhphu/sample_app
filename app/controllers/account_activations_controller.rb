class AccountActivationsController < ApplicationController
  before_action :check_user, only: :edit

  def edit
    @user = User.find_by email: params[:email]
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      redirect_to root_url
    else
      flash[:danger] = t "sendMail.alert2"
      redirect_to root_url
    end
  end

  private
  def check_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "users.notuser"
    redirect_to root_url
  end
end
