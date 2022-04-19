class StaticPagesController < ApplicationController
  def home
<<<<<<< HEAD
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy current_user.microposts
=======
    if logged_in?
      @micropost = current_user.microposts.build
      @pagy, @feed_items = pagy current_user.microposts
    end
>>>>>>> chapter-13
  end

  def help; end

  def contact; end
end
