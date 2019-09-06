class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :correct_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def about
  end

  # def edit
  #   @user = current_user
  #   @userfilter = User.find_by(params[:id])
  #   if @user.id != @userfilter.id
  #     flash[:notice] = "権限がありません"
  #     redirect_to user_home_path(current_user)
  #   end
  # end

  def edit
    @user = current_user
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def new
  end

  # def update
  #   user = current_user
  #   if user.update(user_params)
  #     flash[:notice] = "You have updated user successfully"
  #     redirect_to user_path
  #   else
  #     redirect_to edit_user_path(current_user)
  #     flash[:notice] = "error"
  #   end
  # end

  #redirect_to user_path(current_user)

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy
    super
    session[:keep_signed_out] = true
    flash[:noeice] = "Signed out successfully"
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image ,:user_id)
  end

  def correct_user
    # book = Book.find(params[:id])
    # if current_user.id != book.user_id
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user)
    end
  end

end
