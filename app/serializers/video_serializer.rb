class VideoSerializer
  include JSONAPI::Serializer
  attribute :title
  attribute :file
  attribute :video_url
end
