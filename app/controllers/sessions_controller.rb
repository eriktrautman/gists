class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_user_name(params[:user_name])
    if @user
      sign_in(@user)
      flash[:success] = "Welcome back, #{@user}."
      redirect_to gists_path
    else
      flash[:error] = "We couldn't find that user."
      render 'new'
    end
  end

  def destroy
    cookies.delete(:remember_token)
    redirect_to root_path
  end
end
