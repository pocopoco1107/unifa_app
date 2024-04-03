# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsManager

  # ユーザーがログインしていない場合に/loginへリダイレクト
  def logged_in_user
    redirect_to login_path, status: :see_other unless logged_in?
  end
end
