$('#microposts').prepend('<%= escape_javascript(render('shared/feed_item', feed_item: @micropost))%>').fadeIn('slow')
$('#new_micropost')[0].reset()
$('#charactor_count').html('140')
