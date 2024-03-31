# frozen_string_literal: true

module SessionsManager
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :logged_in?
  end

  # 引数のユーザーでログイン
  # セッションリプレイ攻撃の保護のためuser_idに加えsession_tokenでセッション管理する
  def log_in(user)
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  # ログイン中のユーザーを返す
  def current_user
    return unless session[:user_id]

    user = User.find_by(id: session[:user_id])
    @current_user ||= user if session[:session_token] == user.session_token
  end

  # ユーザーがログインしているか
  def logged_in?
    !current_user.nil?
  end

  # ログアウトする
  def log_out
    reset_session
    @current_user = nil
  end
end
