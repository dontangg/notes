class UsersController < ApplicationController
  skip_before_action :require_sign_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Auto-sign-in the user unless the user is already signed in
      # (eg. creating an account for someone else)
      session[:user_id] = @user.id unless current_user

      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
  end
end
