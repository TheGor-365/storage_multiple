class Post < ApplicationRecord

  has_many_attached :images

  validates :body, presence: true
  validate :image_type

  def thumbnail input
    return self.images[input].variant(resize: '300x300!').processed
  end

  def image_type

    if images.attached? == false
      errors.add(:images, 'are missing')
    end

    images.each do |image|
      if !image.content_type.in?(%('image/jpeg' 'image/png'))
        errors.add(:images, 'needs to be a JPEG or PNG')
      end
    end

  end
end
