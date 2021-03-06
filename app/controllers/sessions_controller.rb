class SessionsController < ApplicationController
  skip_before_action :require_login!, only: [:new, :create]

  before_action :require_login!, only: [:destroy]
  before_action :set_user, only: [:create]

  def new
    if loggedin?
      redirect_to root_path
    end
  end

  def create
    if @user.authenticate(session_params[:password]) && login(@user)
      redirect_to root_path
    else
      flash.now[:alert] = t('.invalid_input')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  def login(user)
    reset_session
    session[:user_id] = user.id
  end

  def logout
    reset_session
  end

  private
    def set_user
      @user = User.find_by!(mail: session_params[:mail])
    rescue
      flash.now[:alert] = t('.invalid_input')
      render action: 'new'
    end

    def session_params
      params.require(:session).permit(:mail, :password)
    end
end
