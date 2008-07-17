function log(x) {
	logdiv = window.document.getElementById("logdiv");
	logdiv.innerHTML += '<div>' + x.toString() + "</div>\n";}
	if (x === '42') {
	logdiv.setAttribute("style", "color: green;");
	} else {
	logdiv.setAttribute("style", "color: red;");
	}

