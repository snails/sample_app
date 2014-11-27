$('#<%= @micropost.id %>').css('background', 'red')
$('#<%= @micropost.id %>').fadeOut -> $(this).remove()
