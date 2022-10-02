module VideoProcessingService
  class GenerateThumbnail

    THUMBNAIL_SIZES = %w(small medium large)

    def initialize(video_id:)
      @video = Video.find(video_id)
    end

    def call
      create_thumbnails
    end

    private

    def create_thumbnails
      THUMBNAIL_SIZES.each do |size|
        Thumbnail.create(video_id: @video.id, size: size, url: thumbnail_url(generate_thumbnail(size).image))
      end
    end

    def generate_thumbnail(size)
      if size == 'small'
        @video.file.preview(resize: "64X64!").processed
      elsif size == 'medium'
        @video.file.preview(resize: "128X128!").processed
      elsif size == 'large'
        @video.file.preview(resize: "256X256!").processed
      end
    end

    def thumbnail_url(image)
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    end
  end
end
