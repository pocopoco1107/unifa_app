# frozen_string_literal: true

class User < ApplicationRecord
  has_many :photos
  validates :code, presence: true, allow_nil: true
  has_secure_password
  validates :password, presence: true, allow_nil: true

  # session_digestが存在しない場合は生成・登録して返す
  def session_token
    unless session_digest
      random_token = SecureRandom.urlsafe_base64
      update(session_digest: BCrypt::Password.create(random_token))
    end
    session_digest
  end

    # ユーザーのログイン情報を破棄する
    def forget
      update(session_digest: nil)
    end
end
