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

                $(document).ready(function () {
                    var styles = {},
                        elements = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'body', 'a', 'span', 'small', 'em', 'blockquote', 'abbr'],
                        attributes = ['font-family', 'font-style', 'font-size', 'line-height', 'font-weight', 'letter-spacing'];

                    console.log($('h2').length);

                    $.map(elements, function (ele, i){
                        styles[ele] = {}
                        $.map(attributes, function(attr, i){
                            if ($(ele).css(attr) !== undefined) {
                                styles[ele][attr] = $(ele).css(attr);
                            }
                        });
                    });

                    // TODO: Check compatibility with ie browsers
                    console.log($.CSSJsonDecode(styles));
                });

            });
            phantom.exit();
        });

    }
});

