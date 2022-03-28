class PasswordResetsController < ApplicationController
  before_action :query_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)
  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "forgotPassword.alert_tc"
      redirect_to root_url
    else
      flash.now[:danger] = t "forgotPassword.alert_tb"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("forgotPassword.alert_1")
      render :edit, status: :unprocessable_entity
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t "forgotPassword.alert_2"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def query_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    return if (@user && @user.activated && @user.authenticated?(:reset, params[:id]))
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "forgotPassword.alert_3"
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end
end
