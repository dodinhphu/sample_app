class MicropostsController < ApplicationController
<<<<<<< HEAD
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t ".create_success"
=======
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = "Micropost created!"
>>>>>>> chapter-13
      redirect_to root_url
    else
      @pagy, @feed_items = pagy current_user.microposts
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  def destroy
    if @micropost.destroy
<<<<<<< HEAD
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
=======
      flash[:success] = "Micropost deleted"
    else
      flash[:danger] = "Deleted fail"
>>>>>>> chapter-13
    end
    redirect_to root_url
  end

  private
  def micropost_params
    params.require(:micropost).permit :content, :image
  end
  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost
<<<<<<< HEAD
    flash[:danger] = t "micropost.micropost_invalid"
=======
    flash[:danger] = "Micropost invalid"
>>>>>>> chapter-13
    redirect_to request.referrer || root_url
  end
end
