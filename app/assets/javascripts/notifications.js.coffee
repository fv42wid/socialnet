class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @notification_count = $("[data-behavior='notification_count']")
    @setup() if @notifications.length > 0

  setup: ->
    $("[data-behavior='notification-link']").on "click", @handleClick
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      method: "POST"
      dataType: "JSON"
      success: ->
        $("[data-behavior='unread-count']").text(0)
    )

  handleSuccess: (data) =>
    #console.log(data.notification_count)
    #console.log(data.notifications["arry!"])
  
    items = $.map data.notifications["arry!"], (notification) ->
      "<li><a class='dropdown-item' href='#{notification.url}'>#{notification.actor.email} #{notification.action} #{notification.notifiable.type}</a></li><button class='btn btn-success btn-xs'>Accept</button><button class='btn btn-danger btn-xs'>Deny</button>"

    $("[data-behavior='unread-count']").text(data.notification_count)
    $("[data-behavior='notification-items']").html(items)
  
jQuery ->
  new Notifications