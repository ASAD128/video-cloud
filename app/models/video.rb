class Video < ApplicationRecord
  has_one_attached :file
  has_one :category
  has_many :thumbnails

  validates :title, presence: true
  validate :file_format

  private
  def file_format
    return unless file.attached?
    if file.blob.content_type.end_with?('video/mp4') || file.blob.content_type.end_with?('video/mov')
      if file.blob.byte_size > 200.megabytes
        errors.add(:file, 'size needs to be less than 200MB')
        file.purge
      end
    else
      file.purge
      errors.add(:file, 'needs to be an video of mp4 or mov format only')
    end
  end
end
