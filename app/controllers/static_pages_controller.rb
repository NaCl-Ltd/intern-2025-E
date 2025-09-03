class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      
        # get pinned post from current user (if exists)
      @pinned_micropost = current_user.microposts.pinned.first

      # Get IDs of users that current user is following
      following_ids = current_user.following.pluck(:id)

      # Get feed items (current user's posts + followed users' posts)
      all_user_ids = [current_user.id] + following_ids

      @feed_items = Micropost.where(user_id: all_user_ids)
                            .where.not(id: @pinned_micropost&.id) #exclude pinned post
                            .order(created_at: :desc)
                            .paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
