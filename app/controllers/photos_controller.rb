# frozen_string_literal: true

class PhotosController < ApplicationController
  require 'net/http'

  before_action :logged_in_user

  def index
    # view側でループでphoto.imageを呼ぶとactive_strage関連テーブルが複数呼び出されN+1問題が発生するため、
    # with_attached_imageスコープにて内部的にincludesを実施する
    @photos = current_user.photos.with_attached_image.order(created_at: :desc) # 新しい順にソート

    # ツイート後のレスポンス内容表示用
    @tweet_responce = if params[:tweet_response_code]
                        {
                          code: params[:tweet_response_code],
                          body: params[:tweet_response_body]
                        }
                      end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      redirect_to photos_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def tweet
    photo = Photo.find(params[:id])
    response = submit_tweet(photo)

    redirect_to action: :index, params: { tweet_response_code: response.code, tweet_response_body: response.body }
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end

  def submit_tweet(photo)
    uri = URI.parse("#{Constants::OAUTH_CONFIG[:auth_base_url]}/api/tweets")
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/json'
    request['Authorization'] = "Bearer #{session[:oauth_access_token]}"
    request.body = {
      text: photo.title,
      url: rails_blob_url(photo.image)
    }.to_json

    Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
  end
end
