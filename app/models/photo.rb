# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [300, 300]
  end

  validates :title, presence: true, length: { maximum: 30 }

  # NOTE: activestorage-validatorを使えばもっと簡潔に実装可能
  validate :image_attached
  validate :image_type, if: -> { image.attached? } # 添付されていない場合は検証しない

  private

  # ファイルが選択されているか
  def image_attached
    errors.add(:image, "が未選択です") unless image.attached?
  end

  # 選択されたファイルが画像ファイルであるか
  def image_type
    unless ["image/jpeg", "image/png"].include?(image.blob.content_type)
      errors.add(:base, "jpeg, pngファイルを選択してください")
    end
  end
end
