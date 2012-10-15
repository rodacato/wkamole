// Read the Phantom webpage '#intro' element text using jQuery and "includeJs"
var page = require('webpage').create(),
    system = require('system'),
    url = system.args[1],
    filename = system.args[2];

page.onConsoleMessage = function(msg) {
    console.log(msg);
};

page.open(url, function(status) {
    if ( status === "success" ) {
        page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
            page.evaluate(function() {
                var styles = {},
                    elements = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'body', 'a', 'span', 'small', 'em', 'blockquote', 'abbr'],
                    attributes = ['font-family', 'font-style', 'font-size', 'color', 'line-height', 'font-weight', 'letter-spacing'];

                $.map(elements, function (ele, i){
                    styles[ele] = {}
                    $.map(attributes, function(attr, i){
                        if ($(ele).css(attr) !== undefined) {
                            styles[ele][attr] = $(ele).css(attr);
                        }
                    });
                });

                var styleStr = "";
                for(var i in styles){
                    styleStr += i + " {\n"
                    for(var j in styles[i]){
                        styleStr += "\t" + j + ":" + styles[i][j] + ";\n"
                    }
                    styleStr += "}\n"
                }

                console.log(styleStr);
            });
            phantom.exit();
        });
    }
});

