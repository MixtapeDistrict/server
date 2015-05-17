function inIframe () {
    try {
        return window.self !== window.top;
    } catch (e) {
        return true;
    }
}

//Handle the location the request is coming from
if(!inIframe()) {
	window.location.href = "/?request="+window.location.href;
}
else {
	window.parent.history.replaceState(null,null,location.href);
}