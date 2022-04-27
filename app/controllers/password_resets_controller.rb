class PasswordResetsController < ApplicationController
  before_action :query_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "forgot_password.alert_tc"
      redirect_to root_url
    else
      flash.now[:danger] = t "forgot_password.alert_tb"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update user_params
      log_in @user
      flash[:success] = t "forgot_password.alert_reset_password"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def query_user
    @user = User.find_by email: params[:email]
    return if @user

    flash.now[:danger]= t "forgot_password.user_not_found"
    redirect_to root_url
  end

  def valid_user
    return if @user && @user.activated && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "forgot_password.alert_expired_token"
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end
end
