result = window.document.getElementById("pluginobj").scriptSimple();

var h = document.createElement("h1");
if (parseInt(result) === 42) {
h.innerHTML = 'PASS :-)';
h.setAttribute("style", "color: green;");
} else {
h.innerHTML = 'FAIL :-(';
h.setAttribute("style", "color: red;");
}
document.getElementsByTagName('body')[0].appendChild(h);
