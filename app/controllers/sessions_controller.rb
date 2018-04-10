class SessionsController < ApplicationController
  before_action :require_login!, [:destroy]
  before_action :set_user, only: [:create]
  
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
  end

  def create
    if @user.authenticate(session_params[:password]) && signin(@user)
      redirect_to root_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
  
  private
    def set_user
      @user = User.find_by!(mail: session_params[:mail])
    rescue
      flash.now[:danger] = t('.flash.invalid_mail')
      render action: 'new'
    end

    def session_params
      params.require(:session).permit(:mail, :password)
    end
end
