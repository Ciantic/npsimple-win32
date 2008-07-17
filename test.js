function log(x) {
	logdiv = window.document.getElementById("logdiv");
	if (parseInt(x) === 42) {
	logdiv.setAttribute("style", "color: green;");
	} else {
	logdiv.setAttribute("style", "color: red;");
	}
	logdiv.innerHTML += '<div>' + x.toString() + "</div>\n";}
