class SendFriendRequestJob < ApplicationJob
  include NotificationsManager
  include Rails.application.routes.url_helpers


  queue_as :default

  def perform(user_id)
    host = 'gembook.me'
    Rails.application.routes.default_url_options[:host] = host

    me = User.find_by(email: ENV['SUPPORT_EMAIL'])
    user = User.find(user_id)
    Friendship.create(sender: me, receiver: user)

    send_notification({ sender: me, 
                        receiver: user, 
                        object_type: 'Friendship', 
                        description: 'new friend request',
                        time_sent: Time.zone.now.to_s,
                        object_url: users_path })
  end
end