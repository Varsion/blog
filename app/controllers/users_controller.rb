class UsersController < ApplicationController

  def create
    user = User.new(create_params)
    if user.save
      render(json: {
        message: "create success"
      })
    else
      render(json: {
        message: user.errors.messages.each { |k, v| "#{k} #{v[0]}" }
      })
    end
  end

  def login
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      render(json: {
        message: "login success",
        token: user.login
      })
    else
      render(json: {
        message: "Invalid email or password"
      })
    end
  end

  private
  def create_params
    params.require(:user).permit(:name, :email, :password)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
