class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.new
  end

  def friends
    @friends = current_user.friends
  end
end
