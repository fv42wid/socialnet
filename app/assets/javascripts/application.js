// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.atwho
//= require_tree .

$(function() {
    $('#dropdownMenu1').click(function() {
	$.ajax({
	    type: "POST",
	    url: "/notifications/mark_as_read",
	    dataType: "JSON",
	    success: $("[data-behavior='unread-count']").text(0)
	});
    });

    // user mention lookup
    
    $('[data-behavior="user-mention-field"]').atwho({
	at: "@", 
	data: "/users/friends.json"
    });

});

