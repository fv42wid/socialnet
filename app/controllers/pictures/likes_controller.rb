class Pictures::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture
  before_action :set_user

  def create
    @picture.likes.where(user_id: current_user.id).first_or_create
    current_user.events.create(action: "liked", eventable: @picture)

    respond_to do |format|
      format.html {redirect_to user_picture_path(@user, @picture) }
      format.js
    end
  end

  def destroy
    @picture.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html {redirect_to user_picture_path(@user, @picture) }
      format.js
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:picture_id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
