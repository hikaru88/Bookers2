class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]

  # def home
  #   @user = current_user
  #   @book = Book.new
  #   @books = Book.all
  #   @book_edit = Book.find(params[:id])
  # end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @users = User.all
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
  end

  # def show
  #   @book = Book.find(params[:id])
  #   @user = @book.user_id
  #   @users = User.find(@user)
  # end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = current_user
    @users = @books.user
  end

  # def ensure_correct_user
  #   @book = Book.find_by(id:params[:id])
  #   if @book.user_id != @current_user.id
  #     flash[:notice] = "権限がありません"
  #     redirect_to user_home_path(current_user)
  # end

  # def create
  #   @book = Book.new(book_params)
  #   @book.user_id = current_user.id
  #   if @book.save
  #     flash[:notice] = "Book was successfully created."
  #     redirect_to book_path(@book.id)
  #   else
  #     redirect_to user_path(current_user)
  #   end
  # end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render "users/show"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  private
  def book_params
    params.require(:book).permit(:user_id, :title, :body,  :profile_image)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      flash[:notice] = "権限がありません。"
      redirect_to books_path
    end
  end

end
