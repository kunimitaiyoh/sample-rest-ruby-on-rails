class ThreadsController < ApplicationController
  def new
    
  end

  def create
    render plain: params[:thread].inspect
  end
end
