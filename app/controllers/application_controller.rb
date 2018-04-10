class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?

  protect_from_forgery with: :exception

  def current_session
    @session ||= Session.find_by(encrypted_id: Session.encrypt(cookies[:session_id]))
  end

  def login(user)
    session_id = Session.new_id
    session_data = { :user_id => user.id }
    
    session = Session.new({ :encrypted_id => Session.encrypt(session_id), :data => session_data })
    
    if session.save
      cookies.permanent[:session_id] = session_id
    end
  end

  def logout
    @session = nil
    cookies.delete(:session_id)
    # TODO: セッションデータ削除
  end

  def loggedin?
    @session.present? && @session.data.has_key?(:user_id)
  end

  private
    def login!
      redirect_to login_path unless loggedin?
    end
end
