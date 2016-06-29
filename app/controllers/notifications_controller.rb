class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient: current_user)
    @notification_count = (Notification.where(recipient: current_user, read_at: nil)).count
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end

#  def show
#    @notifications = Notification.where(recipient: current_user, read_at: nil)
#    #format.js { render :partial => "_show.html.erb" }
#  end

end
