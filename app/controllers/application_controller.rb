class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_notifications

  def get_notifications
    if user_signed_in?
      @notifications = Notification.where(recipient: current_user)
      @notification_count = Notification.where(recipient: current_user, read_at: nil).count
    end
  end
end
