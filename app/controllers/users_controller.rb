class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :follows, :followers]

  def mypage
    redirect_to user_path(current_user)
  end

  def show
    @rooms = @user.rooms
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    binding.pry
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def follows
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:name)
  end
end
