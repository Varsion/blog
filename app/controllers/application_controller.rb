class ApplicationController < ActionController::API

  def current_user
    token = request.headers["Authorization"]
    begin
      data = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      user = User.find_by(id: data["user_id"])

      {user: user, token: token}
    rescue JWT::DecodeError
      {}
    end
  end
end
