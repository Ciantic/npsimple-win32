function setupplugin()
{

var div = document.createElement("div");
div.innerHTML = '<object id="pluginobj" type="application/x-vnd-aplix-jsx"> <param name="archive" value="101.jar"> <param name="launch" value="true"> <param name="log" value="logdiv"> Plugin FAILED to load </object>';
document.documentElement.appendChild(div);

}
