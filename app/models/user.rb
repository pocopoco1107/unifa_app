# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  has_secure_password
  validates :password, presence: true

  def session_token
    unless session_digest
      random_token = SecureRandom.urlsafe_base64
      update(session_digest: BCrypt::Password.create(random_token))
    end
    session_digest
  end
end
