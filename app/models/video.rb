class Video < ApplicationRecord
  has_one_attached :file
  belongs_to :category
  has_many :thumbnails

  validates :title, presence: true
  validate :file_format

  def video_url
    # Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
    Rails.application.routes.url_helpers.url_for(file)
  end

  def thumbnail_url
    thumbnails.last.url
  end

  private
  def file_format
    return unless file.attached?
    # .mov file content_type "video/quicktime"
    if file.blob.content_type.end_with?('video/mp4') || file.blob.content_type.end_with?('video/quicktime')
      if file.blob.byte_size > 200.megabytes
        errors.add(:file, 'size needs to be less than 200MB')
        file.purge
      end
    else
      file.purge
      errors.add(:file, 'needs to be an video of .mp4 or .mov format only')
    end
  end
end
