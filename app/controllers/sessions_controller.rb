class SessionsController < ApplicationController
  before_action :redirect_cats, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      flash[:notice] = "Successfully logged in!"
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << "Credentials not found"
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
