$(document).ready(function () {

  $('.toggle-view').click(function() {
    if ( $('.typography').is(':visible') ) {
      $('.typography').hide();
      $('.code-block').show();
      $(this).text('View example')

    } else {
      $('.typography').show();
      $('.code-block').hide();
      $(this).text('View raw code')

    }
  })
});
