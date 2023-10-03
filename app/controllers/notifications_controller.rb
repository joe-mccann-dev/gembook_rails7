class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.received_notifications.includes([:sender]).order(created_at: :desc)
    @friendships = current_user.requests_via_notification_sender_id
  end

  def update
    @notification = Notification.find(params[:id])

    if @notification.update(notification_params)
      respond_to do |format|
        format.turbo_stream {}
        format.html {
          flash[:info] = 'Notification dismissed'
          redirect_to notifications_path
        }
      end
    else
      flash[:warning] = 'Failed to dismiss notification'
      redirect_to notifications_path
    end
  end

  def dismiss_all
    current_user.received_notifications.map { |n| n.update(read: true) }
    flash[:info] = 'Dismissed all notifications'
    redirect_to notifications_path
  end

  private

  def notification_params
    params.require(:notification).permit(:read)
  end
end
