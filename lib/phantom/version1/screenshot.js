var page = require('webpage').create(),
    system = require('system'),
    url = system.args[1],
    filename = system.args[2],
    assets_file = system.args[3];

page.onConsoleMessage = function(msg) {
    return console.log(msg);
};

page.open(url, function (status) {
    if (status === "success") {
        page.render(filename);

        page.includeJs( assets_file , function() {
            page.evaluate(function() {
                $('body').append('<img class="injected_targetImage" style="display:none" src="http://wkamole.herokuapp.com/images/screenshots/l7g02vj0yb.jpg" />');
console.log('Wrapper inserted');
                $(document).ready(function () {

                    $('.injected_targetImage').bind('load', function (event) {
                      var image = event.target,
                          colors = {};
console.log('Image loaded');
                      // Dominant Color
                      var dominantColor = getDominantColor(image);
                      colors['dominant'] = dominantColor;

                      // Palette
                      var medianPalette = createPalette(image, 16);
                      colors['palette'] = medianPalette;
console.log('colors: ');
                      console.log(JSON.stringify(colors));
                    });

                });
            });
        });
    }

  console.log(filename)
  phantom.exit();
});
