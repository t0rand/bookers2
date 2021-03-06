class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully!'
      redirect_to book_path(@book)
    else
      flash[:caution] = 'Book was false created...'
      @books = Book.all
      @user = current_user
      render action: :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully!'
      redirect_to book_path(@book)
    else
      flash[:caution] = 'Book was false created...(error!)'
      @books = Book.all
      @user = current_user
      render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless current_user.id == @book.user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated!'
      redirect_to book_path(@book)
    else
      flash[:caution] = 'Book was false updated...(error!)'
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy!
      flash[:notice] = 'Book was successfully deleted!'
      redirect_to books_path
    else
      flash[:caution] = 'Book was false deleted...(error!)'
      render book_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
