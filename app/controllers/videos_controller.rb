class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_video, only: %i[ show edit update destroy ]

  # GET /videos
  def index
    @video = Video.last
    render json: VideoSerializer.new(@video).serializable_hash[:data][:attributes]
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # POST /videos
  def create
    @video = Video.new(video_params)
    if @video.save
      generate_thumbnails
      render json: VideoSerializer.new(@video).serializable_hash[:data][:attributes]
    end
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :category_id, :file)
    end

  def generate_thumbnails
    VideoProcessingService::GenerateThumbnail.new(video_id: @video.id).call
  end
end
