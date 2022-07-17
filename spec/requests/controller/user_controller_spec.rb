require "rails_helper"

RSpec.describe "User Controller Rspec", type: :request do

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