module EventsHelper

  def linked_users(body)
    body.gsub /@([\w]+\@[\w]+\.[\w]+)/ do |match|
      link_to $1, user_path(User.select('id').where(email: $1).ids[0])
    end.html_safe
  end

end
