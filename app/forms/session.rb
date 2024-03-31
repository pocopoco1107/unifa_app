# frozen_string_literal: true

class Session
  include ActiveModel::Model

  attr_accessor :code, :password

  validates :code, presence: true
  validates :password, presence: true
  validate :user_exists, if: :validation_passed?

  def user_exists
    user = User.find_by(code:)
    return if user&.authenticate(password)

    errors.add(:base, '該当ユーザーが存在しないか、パスワードが間違っています。')
  end

  # codeとpasswordのバリデーションが成功したかどうかを確認
  def validation_passed?
    errors.blank?
  end
end
