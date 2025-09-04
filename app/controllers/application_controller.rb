class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end
end
