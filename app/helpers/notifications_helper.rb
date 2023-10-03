module NotificationsHelper

  def show_notification(notification, friendships)
    case notification.object_type
    when 'Friendship'
      render partial: 'friendship_notification', locals: { notification: notification }
    else
      turbo_frame_tag "dismiss-notification-#{notification.id}" do
        render partial: 'standard_notification', locals: { notification: notification }
      end
    end
  end
end
