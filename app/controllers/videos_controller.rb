class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_video, only: %i[ show edit update destroy ]

  # GET /videos
  def index
    @videos = Video.all
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # POST /videos
  def create
    @video = Video.new(video_params)
    respond_to do |format|
      if @video.save
        generate_thumbnails
        # format.html { redirect_to controller: "videos", action: "index", format: "html", notice: 'Video was successfully created.' }
        format.html { render json: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :category_id, :file)
      #params.permit(:title, :category_id, :file)
    end

  def generate_thumbnails
    VideoProcessingService::GenerateThumbnail.new(video_id: @video.id).call
  end
end
