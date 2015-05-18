/* A function which checks whether the current request
 * is in an Iframe or not 
 */
function inIframe () {
    try {
        return window.self !== window.top;
    } catch (e) {
        return true;
    }
}

/* Responsible for maintaining browser history and setting
 * the URI of the browser.
 */
if(!inIframe()) {
	window.location.href = "/?request="+window.location.href;
}
else {
	window.parent.history.replaceState(null,null,location.href);
}