if (navigator.plugins["AplixFooPlugin"]) {
	var div = document.createElement("div");
	div.style.visibility = "hidden";
	div.style.borderStyle = "hidden";
	div.style.width = 0;
	div.style.height = 0;
	div.style.border = 0;
	div.style.position = "absolute";
	div.style.top = 0;
	div.style.left = 0;
	div.innerHTML = '<object type="application/x-vnd-aplix-foo" ' +
					'id="pluginobj">' +
					'</object>';
	document.documentElement.appendChild(div);
}

function loadapi(target) {

	var h = document.getElementsByTagName("head")[0];
	var s = document.createElement('script');
	s.type = 'text/javascript';
	s.src = target;
	h.appendChild(s);

}
