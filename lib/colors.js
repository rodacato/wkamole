// Read the Phantom webpage '#intro' element text using jQuery and "includeJs"
var page = require('webpage').create(),
    system = require('system'),
    url = system.args[1],
    assets_file = system.args[2];

page.onConsoleMessage = function(msg) {
    console.log(msg);
};


page.open(url, function(status) {
    if ( status === "success" ) {
        page.includeJs( assets_file , function() {

            page.evaluate(function() {
                var styles = {},
                    elements = ['header', 'footer', 'div', 'aside', 'article'],
                    attributes = ['background-color', 'background-image', 'border-color', 'text-shadow-color', 'color'],
                    typography_elements = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'a', 'span', 'small', 'em', 'blockquote', 'abbr'];

                var colors = $.map(elements, function (element) {
                    return $.unique($(element).find(typography_elements.join(',')).map(function(){ return $(this).css('color'); }).get() )
                }).map(function(ele){ return ele });

                console.log( $.unique(colors)  );

            }); //End evaluate

            phantom.exit();
        }); //End includejs
    }
});

