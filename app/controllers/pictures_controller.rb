class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    if current_user.id == @user.id
      @profile = Profile.find_or_create_by(user_id: @user.id)
      @album = Album.new
      @albums = @user.albums
    end
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
    @albums = @user.albums
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new
    @picture.user_id = @user.id
    @picture.save
    @picture.save_file(params[:picture][:location])
    @picture.album_id = params[:picture][:album_id]

    respond_to do |format|
      if @picture.save
        current_user.events.create(action: "added", eventable: @picture)
        format.html { redirect_to user_pictures_path(@user), notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to user_picture_path(@user, @picture), notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:user_id, :location, :album_id)
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
