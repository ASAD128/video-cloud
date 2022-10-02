class VideosController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]

  # GET /videos or /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1 or /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos or /videos.json
=begin
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to video_url(@video), notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # POST /videos or /videos.json
  def create
    @video = Video.new(video_params)
    respond_to do |format|
      if @video.save
        byebug
        VideoProcessingService::GenerateThumbnail.new(video_id: @video.id).call
        # thumb_nail = @video.file.preview(resize: "300X300").processed
        # path = Rails.application.routes.url_helpers.rails_blob_path(@video.file.preview(resize: "300X300").image, only_path: true)
        #file = @video.file.preview(resize: "300X300").image
        # processed = ImageProcessing::MiniMagick.source(file).resize_to_limit(400, 400).convert("png").call
        # processed = ImageProcessing::MiniMagick.source(thumb_nail.image).resize_to_limit(400, 400).convert("png").call
        # ImageProcessing::MiniMagick .convert("png").resize_to_limit(400, 400).call(file)
        # image = MiniMagick::Image.read(thumb_nail.image.download)

        format.html { redirect_to controller: "videos", action: "index", format: "html", notice: 'Video was successfully created.' }
        # format.json { render :show, status: :created, location: @article }
      else
        # format.html { render :new }
        format.html { redirect_to controller: "videos", action: "index", format: "html", notice: "#{@video.errors}" }
        # Rails.application.routes.url_helpers.rails_representation_url(object.video.preview(resize: "200x200").processed, only_path: true)
        # format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
    # render json: { status: '200' }
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to video_url(@video), notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :category_id, :file)
    end
end
