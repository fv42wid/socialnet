class ProfilesController < ApplicationController
  before_action :set_profile, only: [:update]

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to user_path(@profile.user_id), notice: 'Profile Updated!' }
      else
        format.html { redirect_to user_path(@profile.user_id), notice: 'Not Successful!' }
      end
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:user_id, :profile_picture_id)
    end
end
