class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :latest]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])

    if params[:micropost][:daily_prompt_id].present?
      @micropost.daily_prompt_id = params[:micropost][:daily_prompt_id]
    end 

    if @micropost.save
      flash[:success] = t('text.create_post')
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def latest
    @microposts = Micropost.latest(current_user)
  end

  def destroy
    @micropost.destroy
    flash[:success] = t('text.delete_post')
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end


  def pin
    begin
      @micropost.pin!
      flash[:success] = "Micropost pinned!"
      redirect_back(fallback_location: root_url)
    rescue ActiveRecord::RecordInvalid => e
      flash[:danger] = "Error pinning micropost: #{e.message}"
      redirect_back(fallback_location: root_url)
    end
  end

  def unpin
    @micropost.unpin!
    flash[:success] = "Micropost unpinned!"
    redirect_back(fallback_location: root_url)
  end  

  def calendar
  @posts_by_date = current_user.microposts.group_by { |post| post.created_at.to_date }
  end


  private

    def micropost_params
      params.require(:micropost).permit(:content, :image, :daily_prompt_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end
end
