// Read the Phantom webpage '#intro' element text using jQuery and "includeJs"
var page = require('webpage').create(),
  system = require('system'),
  url = system.args[1],
  filename = system.args[2];

page.onConsoleMessage = function(msg) {
    console.log(msg);
};

if (system.args.length === 1) {
    console.log('Usage: typography.js <some URL>');
    phantom.exit();
}

page.open(url, function(status) {
    if ( status === "success" ) {
        page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
          page.evaluate(function() {
            $.map(['background-color', 'background-image', 'border-color', 'text-shadow-color', 'color'], function (attr){
             console.log("body " + attr + " " + $('body').css(attr));
            });
            $.map(['background-color', 'background-image', 'border-color', 'text-shadow-color', 'color'], function (attr){
             console.log("header " + attr + " " + $('header').css(attr));
            });
            $.map(['background-color', 'background-image', 'border-color', 'text-shadow-color', 'color'], function (attr){
             console.log("footer " + attr + " " + $('footer').css(attr));
            });
          });
          phantom.exit();
        });
    }
});

