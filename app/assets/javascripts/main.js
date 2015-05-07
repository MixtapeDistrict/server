/* A function which takes in the track name and file path
 * of a track and loads it into the JPlayer.
 */
function jplayer_load(name, path, imgpath) {
	console.log("JPlayer song loaded.");
	$("#jquery_jplayer_1").jPlayer("destroy");
	$("#jquery_jplayer_1").jPlayer({
	    ready: function () {
	      $(this).jPlayer("setMedia", {title: name,mp3: "assets/media/"+path}).jPlayer("play",0);
	      increment(path);
	    },
	    cssSelectorAncestor: "#jp_container_1",
	    swfPath: "js",
	    supplied: "mp3",
	    useStateClassSkin: true,
	    autoBlur: false,
	    smoothPlayBar: true,
	    keyEnabled: true,
	    remainingDuration: true,
	    toggleDuration: true
	});
	html='<img class="player-img" src="assets/mediaimage/'+imgpath+'" alt="Player Image">';
	$('.player-img').replaceWith(html);
}

/* Makes AJAX request to database and increments plays */
function increment(path) {
	var xmlhttp;
	/* If newer browser */
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	/* Older browsers IE6 */
	else {
		xmlhttp = ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("post", "/play?path="+path, true);
	xmlhttp.send();
}

