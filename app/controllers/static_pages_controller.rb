class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @pagy, @feed_items = pagy current_user.microposts
    end
  end

  def help; end

  def contact; end
end
