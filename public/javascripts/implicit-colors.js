$(document).ready(function () {
    $('.targetImage').bind('load', function (event) {
        var image = event.target;
        var $image = $(image);
        var appendColors = function (colors, root) {
            var palette = { colors : colors.map(function(val, i){ return {color : val.toString(), color_hex : rgb2hex(val) } }) };
            var html = Mustache.to_html($('#color-template').html(), palette);
            root.append(html);
        };

        // Dominant Color
        var dominantColor = getDominantColor(image);
        var dominantSwatch = $('.colorsWrap .dominant');
        appendColors([dominantColor], dominantSwatch);

        // Palette
        var medianPalette = createPalette(image, 16);
        var medianCutPalette = $('.colorsWrap .palette');
        appendColors(medianPalette, medianCutPalette);
    });
});

function rgb2hex(rgb) {
    //generates the hex-digits for a colour.
    function hex(x) {
        hexDigits = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F");
        return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
    }
    return "#" + hex(rgb[0]) + hex(rgb[1]) + hex(rgb[2]);
}
