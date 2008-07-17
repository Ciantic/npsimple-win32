function log(x) {
	var test = x;
	logdiv = window.document.getElementById("logdiv");
	logdiv.innerHTML += '<div>' + x.toString() + "</div>\n";}
	if (test === '42') {
	logdiv.setAttribute("style", "color: green;");
	} else {
	logdiv.setAttribute("style", "color: red;");
	}

