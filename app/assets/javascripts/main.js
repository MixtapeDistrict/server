/* Makes AJAX request to the database & adds a song to the playlist 
 * Input: Path of the song
 */
function add_playlist(path) {
	var xmlhttp;

	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else {
		xmlhttp = ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.status == 200 && xmlhttp.readyState == 4) {
			console.log("Song added to playlist.");
			console.log(path);
			notify();
			/* Re-render carousel */
			document.getElementById('loader').contentWindow.$("#carousel").removeAttr('style');
			if(typeof document.getElementById('loader').contentWindow.get_playlist == "function") {
				document.getElementById('loader').contentWindow.get_playlist();
			}

			var response = xmlhttp.responseText;
			
			/* Parse the string as XML*/
			if(window.DOMParser) {
				parser = new DOMParser();
				xmlDoc = parser.parseFromString(response, "text/xml");
			}
			else {
				xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
				xmlDoc.async = false;
				xmlDoc.loadXML(response);
			}
			
			/* Begin parsing the information */
			var songs = xmlDoc.getElementsByTagName('track');
			
			/* Update the dropdown list if it is on the page */
			var list = document.getElementById('loader').contentWindow.document.getElementById('playlist_quick_launcher');
			if(list) {
				var html = "You have no songs in your playlist.";
				console.log(songs.length);
				
				for(var i=0; i<songs.length; i++) {
					if(i==0) {
						html = "";
					}
					
					//Populate the dropdown list
					var name = songs[i].childNodes[0].childNodes[0].nodeValue;
					var path = songs[i].childNodes[1].childNodes[0].nodeValue;
					var imgpath = songs[i].childNodes[2].childNodes[0].nodeValue;
					var artist = songs[i].childNodes[3].childNodes[0].nodeValue;
					var artist_id = songs[i].childNodes[4].childNodes[0].nodeValue;
					var rating = songs[i].childNodes[5].childNodes[0].nodeValue;
					var plays = songs[i].childNodes[6].childNodes[0].nodeValue;
					var song_id = songs[i].childNodes[7].childNodes[0].nodeValue;
					var delete_image = "<div class='col-md-1 col-sm-1 col-xs-1 remove-playlist'><a onclick='remove_song("+
									    song_id+")''><img class='delete_image' src='assets/images/remove.png'></a></div>";
					html += "<li class='presentation' role='presentation'>";
					html += "<div class='col-md-11 col-sm-11 col-xs-11 play-list-song'role=\"menuitem\" tabindex=\"-1\" ";
					html += "onclick=\"parent.jplayer_load('" + name + "', '" + path + "',";
			 	    html += " '" + imgpath + "', '" + artist + "', '" + artist_id + "', '" + rating + "', '" + plays + "')\"><p>"+name+"</p></div>";
					html += delete_image;
					html += "</li>";
				}
				console.log(html);
				list.innerHTML = html;
			}
		}
	}

	xmlhttp.open("post", "/add_song?path="+path, true);
	xmlhttp.send();
}

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

	/* AJAX call to check whether the user is logged in or not */
	var xmlhttp;
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else {
		xmlhttp = ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.status == 200 && xmlhttp.readyState == 4) {
			var response = xmlhttp.responseText;
			
			/* User is logged in */
			if(response == "1") {
					html='<img class="player-img" src="assets/mediaimage/'+imgpath+'" alt="Player Image" style="height:50px;width:50px;bottom:0px;">';
					$('.player-img').replaceWith(html);
	
					html='<div class="player-info" style="height:35px;width:250px;left:50px;"><p class="first">Artist: <a id="artist-name" href="/other_profile?id='+artist_id+'" target="main_loader">'+artist+
						 '</a></span></p>'+ "<p>Now playing: " + name + "</p>";
					html += '<a href="assets/media/'+ path +'" download><img class="download" src="assets/images/download.png"></a>';
					html += '<a onclick = "add_playlist(\'' + path +'\')"><img class="add_playlist" src="assets/images/add_playlist.png"></a></div>';
					$('.player-info').replaceWith(html);
			}
			else {
					html='<img class="player-img" src="assets/mediaimage/'+imgpath+'" alt="Player Image" style="height:50px;width:50px;bottom:0px;">';
					$('.player-img').replaceWith(html);
	
					html='<div class="player-info" style="height:35px;width:250px;left:50px;"><p class="first">Artist: <a id="artist-name" href="/other_profile?id='+artist_id+'">'+artist+
						 '</a></span></p>'+ "<p>Now playing: " + name + "</p>";
				    $('.player-info').replaceWith(html);

			}
		}
	}
	xmlhttp.open("get", "/logged_in_status", true);
	xmlhttp.send();

	
};

/* Notifies the user that the song was added to their playlist using AJAX */
function notify() {
	/* AJAX call to check whether the user is logged in or not */
	var xmlhttp;
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else {
		xmlhttp = ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.status == 200 && xmlhttp.readyState == 4) {
			var response = xmlhttp.responseText;
			
			/* User is logged in */
			if(response == "1") {
				/* Clear any old notifications */
				document.getElementById('loader').contentWindow.$('.notifyjs-corner').empty();
				document.getElementById('loader').contentWindow.$.notify("Song added to playlist.",{autoHideDelay: 3000, position: 'top', className:'success'});

			}
			else {
				/* Clear any old notifications */
				document.getElementById('loader').contentWindow.$('.notifyjs-corner').empty();
				document.getElementById('loader').contentWindow.$.notify("You must be signed in to use playlist functionality.",{autoHideDelay: 3000, position: 'top'});
			}
		}
	}
	xmlhttp.open("get", "/logged_in_status", true);
	xmlhttp.send();
}



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


//Function to decide which rating to display on the page
function star_rating(rating) {
	var star = parseFloat(rating);
	var image;

	//Lots of nested ifs for lots of different ratings
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