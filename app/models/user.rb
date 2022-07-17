class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: true
  validates_format_of :email, with: VALID_EMAIL_REGEX
  has_secure_password

  def login
    JWT.encode({
      user_id: id,
      created_at: DateTime.now.strftime("%Q")
    }, Rails.application.credentials.secret_key_base)
  end
end
