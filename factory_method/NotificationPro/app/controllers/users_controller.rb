class UsersController < ApplicationController
  layout "session"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      NotificationFactory.create_notification(:email, @user, "Welcome to our platform, #{@user.name}!")
      redirect_to root_path, notice: "User created successfully!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, notice: "User updated successfully!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
  end
end
