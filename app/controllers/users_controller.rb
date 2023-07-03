class UsersController < ApplicationController
  skip_before_action :authoraize_request

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.to_json, status: :created
    else
      render json: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :image, :bio)
    end
end
