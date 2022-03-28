class UsersController < ApplicationController
  def new; end
  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_path if check? @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t "users.tb_successfully"
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def check? user
    user == nil
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
