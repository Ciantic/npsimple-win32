function setupplugin()
{

// var div = document.createElement("div");
// div.innerHTML = '<object id="pluginobj" type="application/x-vnd-aplix-jsx"> <param name="archive" value="101.jar"> <param name="launch" value="true"> <param name="log" value="logdiv"> Plugin FAILED to load </object>';
// document.documentElement.appendChild(div);

var id = "pluginobj";
var params = { "archive":"101.jar", "launch":"true", "log":"logdiv" };

            var ob = document.createElement("object");
            ob.id = id;
            ob.type = "application/x-vnd-aplix-jsx";
            for(var d in params) {
                var param = document.createElement("param");
                ob.appendChild(param);
                param.name = d;
                param.value = params[d];
            }

document.documentElement.appendChild(ob);

}
