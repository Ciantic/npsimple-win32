function log(x) {
	logdiv = window.document.getElementById("logdiv");
	if (parseInt(x) === 42) {
	logdiv.innerHTML = 'PASS';
	logdiv.setAttribute("style", "color: green;");
	} else {
	logdiv.innerHTML = 'FAIL';
	logdiv.setAttribute("style", "color: red;");
	}
}
