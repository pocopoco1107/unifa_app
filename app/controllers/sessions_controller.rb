class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(code: params[:session][:code])
    if user && user.authenticate(params[:session][:password])
        # TODO: ユーザーのログイン処理
        redirect_to photos_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    # TODO: ログアウト処理

    # NOTE: see_other(303)を返さないとリダイレクト先にもDELETEリクエストしてしまう危険性がある
    redirect_to login_url, status: :see_other
  end
end
