class AuthenticationController < ApplicationController
  skip_before_action :authoraize_request

  # '/api/users/login'にpostしたらjsonを返す
  def login
    @user = User.find_by_email(params[:user][:email])

    if @user&.authenticate(params[:user][:password])
      @user_token = JsonWebToken.encode(user_id: @user.id)
      render json: @user.to_json(@user_token), status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :image, :bio)
  end
end
