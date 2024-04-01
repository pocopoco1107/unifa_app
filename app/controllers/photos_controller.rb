# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :logged_in_user

  def index
    @photos = current_user.photos
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)

    if @photo.save
      redirect_to photos_path
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end
end
