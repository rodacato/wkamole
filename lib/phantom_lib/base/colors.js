// Read the Phantom webpage '#intro' element text using jQuery and "includeJs"
var page = require('webpage').create(),
    system = require('system'),
    url = system.args[1],
    assets_file = system.args[2];

page.onConsoleMessage = function(msg) {
    if (msg.match(/rgb/)){
        console.log(msg);
    }
};

page.open(url, function(status) {
    if ( status === "success" ) {
        page.includeJs( assets_file , function() {

            page.evaluate(function() {
                var styles = {'colors' : [], 'background-colors' : [], 'borders' : []},
                    elements = ['header', 'footer', 'div', 'aside', 'article'],
                    attributes = ['background-color', 'background-image', 'border-color', 'text-shadow-color', 'color'],
                    typography_elements = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'a', 'span', 'small', 'em', 'blockquote', 'abbr'];

                var colors = $.each(elements, function (i, element) {
                        $(element).find(typography_elements.join(',')).each(function(i, typo_element){
                            styles['colors'].push($(typo_element).curStyles('color')['color']);
                            styles['background-colors'].push($(typo_element).curStyles('background-color')['background-color']);
                            styles['borders'].push($(typo_element).curStyles('border-color')['border-color']);
                        }).get();
                    });

                console.log(JSON.stringify(styles));

            }); //End evaluate

            phantom.exit();
        }); //End includejs
    }
});

