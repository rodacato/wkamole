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
				$.map(['h1', 'h2', 'h3', 'h4', 'h5', 'h6'], function (ele, i){
					console.log(">>>>>> " + ele);
					$.map(['font-family', 'font-style', 'font-size', 'color', 'line-height', 'font-weight', 'letter-spacing'], function(attr, i){
						console.log("	" + attr + ': ' + $(ele).css(attr));
					});
				});
			});
            phantom.exit();
        });
    }
});

