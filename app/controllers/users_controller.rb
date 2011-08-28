class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml
  
  def index
    @users = User.all
    respond_with @users
  end
  
  def show
    @user = current_user
    @ideas = current_user.ideas

    respond_with [@user, @ideas]
  end
  
  def edit
    @user = User.find(params[:id])
    respond_with [@user]
  end  
end
