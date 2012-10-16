(function($) {
    $.rgb2Hex = function(rgb){
        //generates the hex-digits for a colour.
        function hex(x) {
            hexDigits = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F");
            return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
        }
        return "#" + hex(rgb[0]) + hex(rgb[1]) + hex(rgb[2]);
    };

    $.CSSJsonDecode = function(obj){
        var styleStr = "";
        for(var i in obj){
            styleStr += i + " {\n"
            for(var j in obj[i]){
                styleStr += "\t" + j + ":" + obj[i][j] + ";\n"
            }
            styleStr += "}\n"
        }
        return styleStr;
    };

    $.fn.getCSS = function(attr){
        var dom = this.get(0);
        var style;
        var returns = {};

        if (dom == undefined){
            return undefined;
        }

        if(window.getComputedStyle){
            var camelize = function(a,b){
                return b.toUpperCase();
            }

            style = window.getComputedStyle(dom, null);

            // TODO: Remove uneeded attributes or just get the one we want a.k.a style[attr]
            for(var i=0;i<style.length;i++){
                var prop = style[i];
                var camel = prop.replace(/\-([a-z])/g, camelize);
                var val = style.getPropertyValue(prop);
                returns[camel] = val;
            }
            return returns[attr];
        }

        if(dom.currentStyle){
            style = dom.currentStyle;
            for(var prop in style){
                returns[prop] = style[prop];
            }
            return returns[attr];
        }
        return this.css('attr');
    };

})(jQuery);
