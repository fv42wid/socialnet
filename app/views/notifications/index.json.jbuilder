json.array! @notifications do |notification|
  json.recipient notification.recipient
  json.actor notification.actor_id
  json.action notification.action
  json.notifiable notification.notifiable_id
  json.url friendship_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end