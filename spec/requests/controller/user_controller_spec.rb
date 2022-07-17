require "rails_helper"

RSpec.describe "User Controller Rspec", type: :request do

  describe "create user" do
    it "Work! email format is error" do
      post "/user",
        params: {
          user: {
            name: "test_name",
            email: "test_name",
            password: "123456"
          }
        }
      expect(response.status).to eq(200)
      expect(response.body).to include_json(
        {"message"=>{"email"=>["is invalid"]}}
      )
    end

    it "Work! name, email or password can't blank" do
      post "/user",
        params: {
          user: {
            name: "test_name",
            email: "test_name@cc.com",
            password: ""
          }
        }
      expect(response.status).to eq(200)
      expect(response.body).to include_json(
        {"message"=>{"password"=>["can't be blank"]}}
      )
    end

    it "Work! Create User Success" do
      post "/user",
      params: {
        user: {
          name: "test_name",
          email: "test_name@cc.com",
          password: "123456"
        }
      }
      expect(response.status).to eq(200)
      expect(response.body).to include_json(
        {"message"=> "create success"}
      )
      expect(User.count).to eq(1)
    end
  end


  describe "login" do
    before :each do
      @user = create(:user)
    end

    it "email can't found" do
      post "/login",
        params: {
          user: {
            email: "c" + @user.email,
            password: "123456"
          }
        }
      expect(response.status).to eq(200)
      expect(response.body).to include_json(
        {
          message: "Invalid email or password"
        }
      )
    end

    it "password is error" do
      post "/login",
        params: {
          user: {
            email: @user.email,
            password: "111111"
          }
        }
      expect(response.status).to eq(200)
      expect(response.body).to include_json(
        {
          message: "Invalid email or password"
        }
      )
    end

    it "login success" do
      post "/login",
        params: {
          user: {
            email: @user.email,
            password: "123456"
          }
        }
      expect(response.status).to eq(200)
      expect(response.body).to include_json(
        {
          message: "login success",
          token: /\w+/
        }
      )
    end
  end
end