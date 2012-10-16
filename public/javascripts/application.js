$(document).ready(function () {

  $('.toggle-view').live('click', function() {
    if ( $('.inner-example-block').is(':visible') ) {
      $('.inner-example-block').hide();
      $('.inner-code-block').show();
      $(this).text('View example')

    } else {
      $('.inner-example-block').show();
      $('.inner-code-block').hide();
      $(this).text('View raw code')

    }
  })
});
