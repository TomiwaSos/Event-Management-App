class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index; end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Successfully created user.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.alert = 'There was something wrong with your log in details'
      render 'index'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Successfully updated user.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Successfully destroyed user.'
  end

  def account_settings
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
