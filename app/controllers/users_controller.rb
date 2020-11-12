class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @books = @user.books
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'successfully!'
      redirect_to user_path(@user.id)
    else
      flash[:caution] = 'error!'
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end