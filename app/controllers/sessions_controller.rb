# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionsManager

  def new
    @login = Session.new
  end

  def create
    @login = Session.new(code: params[:session][:code], password: params[:session][:password])
    user = User.find_by(code: params[:session][:code])
    if @login.valid? && user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to photos_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?

    # NOTE: see_other(303)を返さないとリダイレクト先にもDELETEリクエストしてしまう危険性がある
    redirect_to login_url, status: :see_other
  end
end
