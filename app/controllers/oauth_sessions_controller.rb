# frozen_string_literal: true

class OauthSessionsController < ApplicationController
  require 'net/http'

  def receive_oauth_response
    # アクセストークンを取得
    access_token = fetch_access_token(params[:code])
    # アクセストークンをセッションに保存
    session[:oauth_access_token] = access_token
    # 写真一覧画面へリダイレクト
    redirect_to photos_url if session[:oauth_access_token]
  end

  private

  def fetch_access_token(code)
    uri = URI.parse("#{Constants::OAUTH_CONFIG[:auth_base_url]}/oauth/token")
    request = Net::HTTP::Post.new(uri).tap do |request|
      request.set_form_data(
        client_id: Constants::OAUTH_CONFIG[:client_id],
        client_secret: Constants::OAUTH_CONFIG[:client_secret],
        code: params[:code],
        redirect_uri: Constants::OAUTH_CONFIG[:redirect_uri],
        grant_type: "authorization_code",
      )
    end
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
    JSON.parse(response.body)["access_token"]
  end
end
