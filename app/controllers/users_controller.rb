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
    
  end

  private
  def create_params
    params.require(:user).permit(:name, :email, :password)
  end
end
