$(document).ready(function () {
    $('.targetImage').bind('load', function (event) {
        var image = event.target;
        var $image = $(image);
        var appendColors = function (colors, root) {
			var palette = { colors : colors.map(function(val, i){ return {color : val.toString()} }) };
			var html = Mustache.to_html($('#color-template').html(), palette);
			root.append(html);
        };

        // Dominant Color
        var dominantColor = getDominantColor(image);
        var dominantSwatch = $('.colorsWrap .dominant');
        appendColors([dominantColor], dominantSwatch);

        // Palette
        var medianPalette = createPalette(image, 15);
        var medianCutPalette = $('.colorsWrap .palette');
        appendColors(medianPalette, medianCutPalette);
	});
	//var html = Mustache.to_html($('#template').html(), imageArray);
    //$('#main').append(html);
});
