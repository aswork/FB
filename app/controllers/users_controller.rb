class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
      @user = User.find(params[:id])
    end

    def following
      @user  = User.find(params[:id])
      render '_show_follow'
    end

    def followers
      @user  = User.find(params[:id])
      render '_show_follower'
    end


  private

  def users_params
    params.require(:user).permit(:email, :name)
  end

  def set_user
  @user  = User.find(params[:user_id])
  end



end
