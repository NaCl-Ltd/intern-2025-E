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
      
      @daily_prompt = Prompt.daily_prompt
      @current_language = current_user.preferred_language

      #mark daily prompt as seen if user hasn't seen it
      unless current_user.has_seen_prompt?(@daily_prompt)
        current_user.mark_prompt_as_seen(@daily_prompt)
      end

    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
