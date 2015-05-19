// Make an Array form start to end of size(end-start+1)
function range(start, end) {
    var array = [];
    for (var i = start; i <= end; i++) {
        array.push(i);
    }
    return array;
}

/* Connects to the database and gets the recent 100 tracks from it
 * This could be more but it should provide good recognition
 * for active artists.
 * @returns: The children of the root node.
 */
function get_music() {
	var xmlhttp;
	var xmlDoc;
	/* New browsers */
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	/* IE 6 and older browsers */
	else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	/* Define the function which will be called when the request is completed. */
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.status == 200 && xmlhttp.readyState == 4) {
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
			
			/* Update the grind with this new information */
			update_grind(xmlDoc.getElementsByTagName('song'));
		}
	}
	/* Send the ajax request */
	xmlhttp.open("get", "/get_tracks", true);
	xmlhttp.send();
}    

/* Shows music on the front page.
 * Can be called to update the grind.
 * Can also be called to load the grind the first time.
 */
function update_grind(songs) {

	/* Get an array of indexes */
	var indexes = range(0, songs.length-1);
	
	/* Store the html which will go inside the grind */
	var html = '<div class="row grind">';
	var track_info = '';
	
	/* If there is less than 24 songs in the database, our grind needs to be smaller */
	console.log(songs.length);
	if(songs.length < 24) { 
		for(var i=0;i<songs.length;i++) {
			/* Pick a random index from indexes array */
			var rand = indexes[Math.floor(Math.random() * indexes.length)];
			
			/* Remove this index from indexes array so it doesn't get picked again */
			for(var x=0; x<indexes.length; x++) {
				if(indexes[x]==rand) {
					indexes.splice(x, 1);
				}
			}

			track_name = songs[rand].childNodes[0].childNodes[0].nodeValue;
			track_comment = songs[rand].childNodes[1].childNodes[0].nodeValue;
			artist_name = songs[rand].childNodes[2].childNodes[0].nodeValue;
			profile_id = songs[rand].childNodes[3].childNodes[0].nodeValue;
			track_img = songs[rand].childNodes[4].childNodes[0].nodeValue;
			track_path = songs[rand].childNodes[5].childNodes[0].nodeValue;
			track_album = songs[rand].childNodes[6].childNodes[0].nodeValue;
			plays_num = songs[rand].childNodes[8].childNodes[0].nodeValue;
			rating = songs[rand].childNodes[9].childNodes[0].nodeValue;
			genre = songs[rand].childNodes[10].childNodes[0].nodeValue;
			

			track_info = '<p class="h4">' + track_name +'</p>'+
			             '<p class="name">Artist: <a class="artistname" href="/other_profile?id='+profile_id+'">' + artist_name +
			             '</a></p>'+ '<p>Genre: ' + genre + '</p>' + '<p>Plays: ' + plays_num +
			             '</p><p>Ratings: ' + rating + '/5';

			playtrack = '<a onclick="parent.jplayer_load(\'' + track_name +'\',\'' + track_path + '\',\'' + track_img +'\',\'' +
						 artist_name + '\',\'' + profile_id + '\',\'' + rating + '\',\'' + plays_num + '\')">'+
						'<img class="playtrack" src="assets/images/play.png"></a>';

			comment = '<a href="/comments?id='+ track_comment +'"><img class="comment" src="assets/images/comment.ico"></a>';
			playlist = '<a onclick="parent.add_playlist(\''+track_path+'\')"><img class="add_playlist" src="assets/images/add_playlist.png"></a>';

			html += '<div onclick="" class="element"><img id="track" class="col-md-2 img-thumbnail" alt="" src="assets/mediaimage/'+ track_img +
					'"><div class="grid_description">'+ track_info +'</div>'+ playtrack + playlist + comment+'</div>';
		}
	}
	/* There is more than 24 songs in the database, our grind is good size. */
	else {
		for(var i=0;i<24;i++) {
			/* Pick a random index from indexes array */
			var rand = indexes[Math.floor(Math.random() * indexes.length)];
			
			/* Remove this index from indexes array so it doesn't get picked again */
			for(var x=0; x<indexes.length; x++) {
				if(indexes[x]==rand) {
					indexes.splice(x, 1);
				}
			}

			track_name = songs[rand].childNodes[0].childNodes[0].nodeValue;
			track_comment = songs[rand].childNodes[1].childNodes[0].nodeValue;
			artist_name = songs[rand].childNodes[2].childNodes[0].nodeValue;
			profile_id = songs[rand].childNodes[3].childNodes[0].nodeValue;
			track_img = songs[rand].childNodes[4].childNodes[0].nodeValue;
			track_path = songs[rand].childNodes[5].childNodes[0].nodeValue;
			track_album = songs[rand].childNodes[6].childNodes[0].nodeValue;
			plays_num = songs[rand].childNodes[8].childNodes[0].nodeValue;
			rating = songs[rand].childNodes[9].childNodes[0].nodeValue;
			genre = songs[rand].childNodes[10].childNodes[0].nodeValue;


			track_info = '<p class="h4">' + track_name +'</p>'+
			             '<p class="name">Artist: <a class="artistname" href="/other_profile?id='+profile_id+'">' + artist_name +
			             '</a></p>'+ '<p>Genre: ' + genre + '</p>' + '<p>Plays: ' + plays_num +
			             '</p><p>Ratings: ' + rating + '/5';

			playtrack = '<a onclick="parent.jplayer_load(\'' + track_name +'\',\'' + track_path + '\',\'' + track_img +'\',\'' +
						 artist_name + '\',\'' + profile_id + '\',\'' + rating + '\',\'' + plays_num + '\')">'+
						'<img class="playtrack" src="assets/images/play.png"></a>';

			comment = '<a href="/comments?id='+ track_comment +'"><img class="comment" src="assets/images/comment.ico"></a>';
            playlist = '<a onclick="parent.add_playlist(\''+track_path+'\')"><img class="add_playlist" src="assets/images/add_playlist.png"></a>';
			html += '<div onclick="" class="element"><img id="track" class="col-md-2 img-thumbnail" alt="" src="assets/mediaimage/'+ track_img +
					'"><div class="grid_description">'+ track_info +'</div>'+ playtrack + playlist + comment+'</div>';
		}
	}
	html += '</div>'
	
	/* Replace the grind HTML with the HTML this function generates. */
	/* Put all racks in place */
	$('.grind').replaceWith(html);
}

/* Connects to the database and gets the user's playlist using AJAX. */
function get_playlist() {
	var xmlhttp;
	var xmlDoc;
	
	/* New browsers */
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	/* IE 6 and older browsers */
	else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	/* Define the function which will be called when the request is completed. */
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.status == 200 && xmlhttp.readyState == 4) {
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
			
			/* Load the playlist into the carousel */
			angle=0;
			load_playlist(xmlDoc.getElementsByTagName('image'));
		}
	}

	/* Send the ajax request */
	xmlhttp.open("get", "/playlist", true);
	xmlhttp.send();
}



function load_playlist(playlist) {
	var data=[];
	for (var i=0; i<playlist.length; i++) {
		var image = playlist[i].childNodes[0].nodeValue;
		
		/* Push all the image sources to the carousel */
		data.push("assets/mediaimage/"+image+"");
	}
	doCarousel(data);
}





/* Fill up the grind */
get_music();

// Enable these functionalities when page is loaded   
$(document).ready(function(){

    // Generates new songs for the grind
    $('.new-songs').click(function(){
    	var interval = null;
        var counter = 0;
        var $this = $('.refresh');
        clearInterval(interval);
 
        //Rotate the refresh icon once 
        interval = setInterval(function(){
            if (counter != -360) {
                counter -= 5;
                $this.css({
                    MozTransform: 'rotate(-' + -counter + 'deg)',
                    WebkitTransform: 'rotate(' + -counter + 'deg)',
                    transform: 'rotate(' + -counter + 'deg)'
                });
            }
        }, 10);
        get_music();       
	});
	
	// Do Carousel	// Will pull this from server. Static for now.
    
    // Create the elements to display in the carousel
	get_playlist();

});

// Carousel JavaScript

// Created using http://desandro.github.io/3dtransforms/docs/carousel.html as a tutorial/guide
// I refactored and revamped just about all code from there, but it is possible a few variable names are the same

var PANEL_SIZE = 130;
var TO_RADIANS = Math.PI/180;
var BACKFACE_INVISIBLE = true;
var selectedIndex = 0;
var carouselData = null;
var RADIUS_SIZE = 300;

// Creates a Carousel from an Array 
function doCarousel(data){
	carouselData = data;
	angle = 0;
    var spinner = $("#carousel");
    spinner.empty();
    selectedIndex = 0;
    var interval = 360/data.length;
    var r = RADIUS_SIZE;
	
	//Put elements into the carousel
    for(var i = 0 ; i < data.length ; i++) {
        var newElement = $("<img src=\""+data[i]+"\">");
        var num = interval*i;
        newElement.css("transform","rotateY( " + num + "deg ) translateZ( "+r+"px )");
        
		//Configure read of carousel panels
        var backfaceVisibility = BACKFACE_INVISIBLE ? "hidden" : "visible";
        newElement.css("-webkit-backface-visibility",backfaceVisibility);
        newElement.css("backface-visibility",backfaceVisibility);
        spinner.append(newElement);
    }

    /* Populate the div next to the carousel on the first call */
   	if(data.length > 0) {
   		/*  TRYING TO ADD TRACK DETAILS HERE. */
		TRACKNAME = "<p class='T1'></p>";
		ARTIST = "<div class='T2'></div>";
		PLAYS = "<div class='T3'></div>";
		GENRE = "<div class='T4'></div>";
		RATING = "<div class='T5'></div>";
		BUTTONS = "<span class='T6'></span>";
    	div_text = $("<div id='information'>"+ TRACKNAME + ARTIST + PLAYS + GENRE + RATING + BUTTONS +"</div>");
    	spinner.append(div_text);
   		populate_playlist_div(data[0]);
   	}
   	else {
   		// populate_playlist_div("empty");
   		// <img src='assets/images/error.jpg'>
   		var newElement = $("<h3 style='color:white;position:absolute;margin-top:98px'>Playlist is empty.</h3>");
        var num = interval*i;
        newElement.css("transform","rotateY( " + num + "deg ) translateZ( "+r+"px )");
        
        var backfaceVisibility = BACKFACE_INVISIBLE ? "hidden" : "visible";
        newElement.css("-webkit-backface-visibility",backfaceVisibility);
        newElement.css("backface-visibility",backfaceVisibility);
        spinner.append(newElement);
   	}
}

/* Removes a song from the carousel(User's playlist) */
function remove_song(song_id) {
	var xmlhttp;
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else {
		xmlhttp = ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.status == 200 && xmlhttp.readyState == 4) {
			console.log("Song removed");
			$("#carousel").removeAttr('style');
			selectedIndex = 0;
			get_playlist();
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
			/* Clear any old notifications */
			$('.notifyjs-corner').empty();
			$.notify("Song removed from playlist.",{autoHideDelay: 3000, position: 'top'});
			populate_quicklaunch_bar(xmlDoc);
		}
	}
	
	/* Open and send ajax request */
	xmlhttp.open("get", "/playlist_remove?song_id="+song_id, true);
	xmlhttp.send();

}

/* Populates quick launch bar */
function populate_quicklaunch_bar(xmlDoc) {
	/* Begin parsing the information */
	var songs = xmlDoc.getElementsByTagName('track');
	
	/* Update the dropdown list if it is on the page */
	var list = document.getElementById('playlist_quick_launcher');
	if(list) {
		var html = "<li role='presentation'><a role = 'menuitem' tabindex='-1'>You have no songs in your playlist.</a></li>";
		console.log(songs.length);
		
		//Add individual songs into the list
		for(var i=0; i<songs.length; i++) {
			if(i==0) {
				html = "";
			}
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
		list.innerHTML = html;
	}
}

/* Populates the DIV next to the playlist with information
 * given an image path of the current focused song.
 */
function populate_playlist_div(image_path) {
	var xmlhttp;
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else {
		xmlthttp = ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.status == 200 && xmlhttp.readyState == 4) {
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
			
			/* Store the required information */
			console.log("<---- START OF CAROUSEL FOCUS ---->");
			var track_title = xmlDoc.getElementsByTagName('title')[0].childNodes[0].nodeValue;
			var song_id = xmlDoc.getElementsByTagName('songID')[0].childNodes[0].nodeValue;
			var artist_name = xmlDoc.getElementsByTagName('artist')[0].childNodes[0].nodeValue;
			var artist_id = xmlDoc.getElementsByTagName('artistID')[0].childNodes[0].nodeValue;
			var file_path = xmlDoc.getElementsByTagName('filePath')[0].childNodes[0].nodeValue;
			var genre = xmlDoc.getElementsByTagName('genre')[0].childNodes[0].nodeValue;
			var plays = xmlDoc.getElementsByTagName('plays')[0].childNodes[0].nodeValue;
			var rating = xmlDoc.getElementsByTagName('rating')[0].childNodes[0].nodeValue;
			var img = xmlDoc.getElementsByTagName('imagePath')[0].childNodes[0].nodeValue;

		/* ADD INFORMATION TO NEW TRACK AREA. */

			$('.T1').text(track_title);
			$('.T2').html("<p>Artist: " + artist_name + "</p>");
			$('.T3').html("<p>Genre: " + genre + "</p>");
			$('.T4').html("<p>Plays: " + plays + "</p>");
			$('.T5').html("<p>Rating: " + rating + "</p>");
			$('.T6').html("<a  id=\"B1\" onclick=\"parent.jplayer_load('"+track_title+"','"+file_path+"','"+
				img+"','"+artist_name+"','"+artist_id+"','"+rating+"','"+plays+"')\"><img src=\"assets/images/play.png\"></a>" +
				"<a  id=\"B2\" href = '/comments?id="+song_id+"'><img src='assets/images/comment.ico'></a>" +
				"<a  id=\"B3\" onclick = 'remove_song("+song_id+")'><img  src ='assets/images/remove.png'></a>");
		}
	}
	
	//Handle empty image paths
	if(image_path != "empty") {
		xmlhttp.open("get", "/track_info?image_path="+image_path, true);
		xmlhttp.send();
	}
	else {
		//Otherwise insert the data
		document.getElementById('carousel-track-name').innerHTML = "";
		document.getElementById('carousel-track-artist').innerHTML = "";
		document.getElementById('carousel-track-plays').innerHTML = "";
		document.getElementById('carousel-track-genre').innerHTML = "";
		document.getElementById('carousel-track-rating').innerHTML = "";
		document.getElementById('carousel-track-controls').innerHTML = "";
	}
}


// Makes the images on the carousel spin, updating the css
var angle = 0;
function galleryspin(sign) {
    var carousel = document.querySelector('#carousel');
    var numPanels = carousel.children.length - 1;
    var increment = sign ? -1 : 1;

	selectedIndex+=increment;
	if(selectedIndex >= carouselData.length){
		selectedIndex-=carouselData.length;
	}else if(selectedIndex < 0){
		selectedIndex+=carouselData.length;
	}
	
	console.log(selectedIndex);
	console.log(carouselData[selectedIndex]);
	console.log("Panels in carousel = " + numPanels);
	console.log("Increment = " + increment);
	
	/* Use this image path to populate the div next to the carousel */
	populate_playlist_div(carouselData[selectedIndex]);

    //Handle the transforms
    angle += ( -360 / numPanels ) * increment;
    carousel.style[ '-webkit-transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';
    document.querySelector('#information').style[ '-webkit-transform' ] = 'translateZ( 0px ) rotateY(' + (-1) * angle + 'deg)';
    carousel.style[ 'transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';
	document.querySelector('#information').style[ 'transform' ] = 'translateZ( 0px ) rotateY(' + (-1) * angle + 'deg)'

}

/* Shuffles the carousel */
function shuffle() {
	/* Change the button to something intuitive */
	var shuffle_button = document.getElementById('random');
	shuffle_button.disabled = true;
	$('#random b').text("Shuffling..");

	/* After 1 second enable the button */
	setTimeout (function(){
        shuffle_button.disabled = false;
        $('#random b').text("Shuffle Playlist");
    },1000);

	/* Change the name inside the button */
	var carousel = document.querySelector('#carousel');
	/* Get how much panels are inside the carousel */
	var numPanels = carousel.children.length - 1;
	/* Generate a random number between 0 and numPanels */
	var rand = Math.floor(Math.random()*numPanels + 1);
	

	/* Spin the carousel rand times in the positive direction */
	for(var i=0; i<rand; i++) {
		var increment = 1;

		selectedIndex+=increment;
		if(selectedIndex >= carouselData.length){
			selectedIndex-=carouselData.length;
		}else if(selectedIndex < 0){
			selectedIndex+=carouselData.length;
		}
	
		console.log(selectedIndex);
		console.log(carouselData[selectedIndex]);
		console.log("Panels in carousel = " + numPanels);
		console.log("Increment = " + increment);
		//Handle the transforms
        angle += ( -360 / numPanels ) * increment;
        carousel.style[ '-webkit-transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';
        document.querySelector('#information').style[ '-webkit-transform' ] = 'translateZ( 0px ) rotateY(' + (-1) * angle + 'deg)';
        carousel.style[ 'transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';
	    document.querySelector('#information').style[ 'transform' ] = 'translateZ( 0px ) rotateY(' + (-1) * angle + 'deg)';
	}

	/* Use this image path to populate the div next to the carousel */
	populate_playlist_div(carouselData[selectedIndex]);

}

$("#comment-form").submit(function() {
    $(this).submit(function() {
        return false;
    });
    return true;
});


