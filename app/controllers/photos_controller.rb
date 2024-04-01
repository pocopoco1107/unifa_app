# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :logged_in_user

  def index
    @photos = current_user.photos.order(created_at: :desc) # 新しい順にソート
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
