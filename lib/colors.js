// Read the Phantom webpage '#intro' element text using jQuery and "includeJs"
var page = require('webpage').create(),
    system = require('system'),
    url = system.args[1],
    host = system.args[2];

page.onConsoleMessage = function(msg) {
    console.log(msg);
};

if (system.args.length === 1) {
    console.log('Usage: typography.js <some URL>');
    phantom.exit();
}

page.open(url, function(status) {
    if ( status === "success" ) {
        page.includeJs(host + "/javascripts/includes/jquery.min.js", function() {
          page.evaluate(function() {
            var elements = ['body', 'header', 'footer', 'div', 'aside', 'article']
            var attributes = ['background-color', 'background-image', 'border-color', 'text-shadow-color', 'color']
            var styles = {}

            $.map(elements, function (element) {
              var elementList = $(element)
              elementList.each(function(index) {
                styles[element + "_" + index] = {}

                var currentElement = $(this)
                $.map(attributes, function(attr, i){
                    if (currentElement.css(attr) !== (undefined || null || 'none') ) {
                        styles[element + "_" + index][attr] = currentElement.css(attr);
                    }
                });

              });
            });
            console.log(JSON.stringify(styles))

          });
          phantom.exit();
        });
    }
});

