/* A function which takes in the track name and file path
 * of a track and loads it into the JPlayer.
 */
function jplayer_load(name, path) {
	console.log("JPlayer song loaded.");
	$("#jquery_jplayer_1").jPlayer("destroy");
	$("#jquery_jplayer_1").jPlayer({
	    ready: function () {
	      $(this).jPlayer("setMedia", {title: name,mp3: "assets/media/"+path}).jPlayer("play",0);
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
}


