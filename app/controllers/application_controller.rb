class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authoraize_request

  def authoraize_request
    # Authorizationヘッダーを取得
    header = request.headers['Authorization']
    # "Authorization": <"認証方法(BearerやOAuth)> <トークン">の形式
    token = header.split(' ').last if header

    begin
      # トークン復号
      @decoded = JsonWebToken.decode(token)
      # Json形式になったものからuser_idを探し、そのユーザー情報をcurrent_userに
      @current_user = User.find(@decoded[:user_id])

    rescue ActiveRecord::RecordNotFound
      render_unauthorized
    rescue JWT::DecodeError
      render_unauthorized
    end
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
