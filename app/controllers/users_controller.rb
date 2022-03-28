class UsersController < ApplicationController
<<<<<<< HEAD
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)

  def show
    @pagy, @microposts = pagy @user.microposts
=======
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def destroy
    if @user.destroy
      flash[:success] = t "users.text_5"
    else
      flash[:danger] = t "users.text_6"
    end
    redirect_to users_url
  end

  def index
   @pagy, @users = pagy(User.all)
  end

  def new; end
  def show
>>>>>>> chapter-10
    redirect_to root_path if check? @user
  end

  def index
    @pagy, @users = pagy User .ordered_by_name
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_mail_activate
      flash[:info] = t "sendMail.alert1"
      redirect_to login_url
    else
      flash[:danger] = t ".create_fail"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
<<<<<<< HEAD
    if @user.update user_params
      flash[:success] = t "users.tb_update_successfully"
      redirect_to @user
    else
      flash[:danger] = t "users.update_fail"
=======
    if @user.update(user_params)
      flash[:success] = t "users.tb_update_successfully"
      redirect_to @user
    else
>>>>>>> chapter-10
      render :edit, status: :unprocessable_entity
    end
  end

<<<<<<< HEAD
  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to users_url
  end

=======
>>>>>>> chapter-10
  private
  def check? user
    user == nil
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
<<<<<<< HEAD
    return if logged_in?

    store_location
    flash[:danger] = t "users.alert"
    redirect_to login_url
  end

  def correct_user
=======
    unless logged_in?
      store_location
      flash[:danger] = t "users.alert"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
>>>>>>> chapter-10
    redirect_to(root_url) unless current_user?(@user)
  end

  def load_user
    @user = User.find_by(id: params[:id])
<<<<<<< HEAD
    return if @user

=======
    return @user if @user
>>>>>>> chapter-10
    flash[:danger] = t "users.notuser"
    redirect_to root_path
  end
end
