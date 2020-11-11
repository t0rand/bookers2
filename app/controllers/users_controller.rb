class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @current_user = current_user
    @user = User.find(params[:id])
  end

  def show
    @current_user = current_user
    @user = User.find(params[:id])
    @users = User.all
    @books = @user.books
    @book = Book.new
  end

  def index
    @current_user = current_user
    @users = User.all
  end

  def update
    @current_user = current_user
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end