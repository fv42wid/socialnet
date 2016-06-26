json.array! @notifications do |notification|
  json.id notification.id
  json.actor User.find(notification.actor_id)
  json.action notification.action
  json.notifiable do #notification.notifiable_id
    json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
  json.url friendship_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end