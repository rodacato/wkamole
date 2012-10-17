// Read the Phantom webpage '#intro' element text using jQuery and "includeJs"
var page = require('webpage').create(),
    system = require('system'),
    url = system.args[1];

page.onConsoleMessage = function(msg) {
    if (!msg.match(/(Unsafe|TypeError)/)){
        console.log(msg);
    }
};

page.open(url, function(status) {
    if ( status === "success" ) {
        page.evaluate(function() {
            $(document).ready(function () {
                var colors = $('.colors').html()
                console.log(colors);
            });
        });
        phantom.exit();
    }
});

