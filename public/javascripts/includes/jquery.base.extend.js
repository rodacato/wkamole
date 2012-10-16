(function($) {
	$.extend({
		rgb2Hex: function(rgb){
		        //generates the hex-digits for a colour.
		        function hex(x) {
		            hexDigits = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F");
		            return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
		        }
		        return "#" + hex(rgb[0]) + hex(rgb[1]) + hex(rgb[2]);
		    },
	
		CSSJsonDecode: function(obj){
		        var styleStr = "";
		        for(var i in obj){
		            styleStr += i + " {\n"
		            for(var j in obj[i]){
		                styleStr += "\t" + j + ":" + obj[i][j] + ";\n"
		            }
		            styleStr += "}\n"
		        }
		        return styleStr;
		    }
	});

})(jQuery);
