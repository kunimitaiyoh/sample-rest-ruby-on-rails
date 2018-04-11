class ApplicationController < ActionController::Base
  before_action :require_login!
  helper_method :loggedin?

  protect_from_forgery with: :exception

  def loggedin?
    session.has_key?(:user_id)
  end

  private
    def require_login!
      redirect_to login_path unless loggedin?
    end
end
