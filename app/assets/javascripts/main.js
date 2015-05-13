/* A function which takes in the track name && file path
 * of a track && loads it into the JPlayer.
 */
function jplayer_load(name, path, imgpath, artist, artist_id, rating, plays) {
	console.log("JPlayer song loaded.");
	$("#jquery_jplayer_1").jPlayer("destroy");
	$("#jquery_jplayer_1").jPlayer({
	    ready: function () {
	      $(this).jPlayer("setMedia", {title: name,mp3: "assets/media/"+ path}).jPlayer("play",0);
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
	html='<img class="player-img" src="assets/mediaimage/'+imgpath+'" alt="Player Image" style="height:50px;width:50px;bottom:0px;">';
	$('.player-img').replaceWith(html);
	
	html='<div class="player-info" style="height:35px;width:250px;left:50px;"><p class="first">Artist: <a id="artist-name" href="/other_profile?id='+artist_id+'">'+artist+
		 '</a></span></p></div>';
	html += '<a href="assets/media/'+ path +'" download><img class="download" src="assets/images/download.png"></a>';
	html += '<a><img class="add_playlist" src="assets/images/add_playlist.png"></a>'
	$('.player-info').replaceWith(html);
};

/* Makes AJAX request to database && increments plays */
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
};

function star_rating(rating) {
	var star = parseFloat(rating);
	var image;

	if (star <= 0.5) {
		image = '<img class="star-rating" src="assets/images/0.5.png">';	
	} else if ((star > 0.5) && (star <= 1.0)){
		image = '<img class="star-rating" src="assets/images/1.0.png">';
	} else if ((star > 1.0) && (star <= 1.5)){
		image = '<img class="star-rating" src="assets/images/1.5.png">';
	} else if ((star > 1.5) && (star <= 2.0)){
		image = '<img class="star-rating" src="assets/images/2.0.png">';
	} else if ((star > 2.0) && (star <= 2.5)){
		image = '<img class="star-rating" src="assets/images/2.5.png">';
	} else if ((star > 2.5) && (star <= 3.0)){
		image = '<img class="star-rating" src="assets/images/3.0.png">';
	} else if ((star > 3.0) && (star <= 3.5)){
		image = '<img class="star-rating" src="assets/images/3.5.png">';
	} else if ((star > 3.5) && (star <= 4.0)){
		image = '<img class="star-rating" src="assets/images/4.0.png">';
	} else if ((star > 4.0) && (star <= 4.5)){
		image = '<img class="star-rating" src="assets/images/4.5.png">';
	} else if ((star > 4.5) && (star <= 5.0)){  
		image = '<img class="star-rating" src="assets/images/5.0.png">';	
	} else {
		image = 'No rating';
	}

	return image;                                     
};