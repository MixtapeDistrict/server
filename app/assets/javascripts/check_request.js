function inIframe () {
    try {
        return window.self !== window.top;
    } catch (e) {
        return true;
    }
}

if(!inIframe()) {
	window.location.href = '/error';
}