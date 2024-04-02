# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :logged_in_user

  def index
    # view側でループでphoto.imageを呼ぶとactive_strage関連テーブルが複数呼び出されN+1問題が発生するため、
    # with_attached_imageスコープにて内部的にincludesを実施する
    @photos = current_user.photos.with_attached_image.order(created_at: :desc) # 新しい順にソート
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

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end
end
