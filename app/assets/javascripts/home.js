/* A function which shuffles an array */
function shuffle(array) {
    var size = array.length;
    var random_index;
	/* While there remain elements to shuffle */
	for(var i=0; i<array.length; i++) {
		/* Pick a random index from the array */
		random_index = Math.floor(Math.random()*array.length);
		/* Swap this random index with the current index */
		var temp = array[i];
		array[i] = array[random_index];
		array[random_index] = temp;
	}
	return array;
}

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
			

			track_info = '<p class="h4">' + track_name +'</p>'+
			             '<p class="name">Artist: <a class="artistname" href="/other_profile?id='+profile_id+'">' + artist_name +
			             '</a></p><p class="name">Album: ' + track_album +
			             '</p><p>Plays: ' + plays_num +
			             '</p><p>Ratings: ' + rating + '/5';

			playtrack = '<a onclick="parent.jplayer_load(\'' + track_name +'\',\'' + track_path + '\',\'' + track_img +'\',\'' +
						 artist_name + '\',\'' + profile_id + '\',\'' + rating + '\',\'' + plays_num + '\')">'+
						'<img class="playtrack" src="assets/images/play.png"></a>';

			comment = '<a href="/comments/music/?id='+ track_comment +'"><img class="comment" src="assets/images/comment.ico"></a>';

			html += '<div onclick="" class="element"><img id="track" class="col-md-2 img-thumbnail" alt="" src="assets/mediaimage/'+ track_img +
					'"><div class="grid_description">'+ track_info +'</div>'+ playtrack + comment+'</div>';
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
			

			track_info = '<p class="h4">' + track_name +'</p>'+
			             '<p class="name">Artist: <a class="artistname" href="/other_profile?id='+profile_id+'">' + artist_name +
			             '</a></p><p class="name">Album: ' + track_album +
			             '</p><p>Plays: ' + plays_num +
			             '</p><p>Ratings: ' + rating + '/5';

			playtrack = '<a onclick="parent.jplayer_load(\'' + track_name +'\',\'' + track_path + '\',\'' + track_img +'\',\'' +
						 artist_name + '\',\'' + profile_id + '\',\'' + rating + '\',\'' + plays_num + '\')">'+
						'<img class="playtrack" src="assets/images/play.png"></a>';

			comment = '<a href="/comments/music/?id='+ track_comment +'"><img class="comment" src="assets/images/comment.ico"></a>';

			html += '<div onclick="" class="element"><img id="track" class="col-md-2 img-thumbnail" alt="" src="assets/mediaimage/'+ track_img +
					'"><div class="grid_description">'+ track_info +'</div>'+ playtrack + comment+'</div>';
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

// Creates a Carousel from an Array 
function doCarousel(data){
	
	carouselData = data;
	
    var spinner = $("#carousel");
    spinner.empty();
    var interval = 360/data.length;
    var r = PANEL_SIZE/(Math.tan((interval/2)*TO_RADIANS));
    for(var i = 0 ; i < data.length ; i++) {
        var newElement = $("<img src=\""+data[i]+"\">");
        var num = interval*i;
        newElement.css("transform","rotateY( " + num + "deg ) translateZ( "+r+"px )");
        
        var backfaceVisibility = BACKFACE_INVISIBLE ? "hidden" : "visible";
        newElement.css("-webkit-backface-visibility",backfaceVisibility);
        newElement.css("backface-visibility",backfaceVisibility);
        spinner.append(newElement);
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
		if(xmlhttp.request == 200 && xmlhttp.readyState == 4) {
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
		}
	}
	xmlhttp.open("get", "/track_info?image_path="+image_path, true);
	xmlhttp.send();
}

// Makes the images on the carousel spin, updating the css
var angle = 0;
function galleryspin(sign) {
    var carousel = document.querySelector('#carousel');
    var numPanels = carousel.children.length;
    var increment = sign ? -1 : 1;
    
	selectedIndex+=increment;
	if(selectedIndex >= carouselData.length){
		selectedIndex-=carouselData.length;
	}else if(selectedIndex < 0){
		selectedIndex+=carouselData.length;
	}
	
	console.log(selectedIndex);
	console.log(carouselData[selectedIndex]);
	/* Use this image path to populate the div next to the carousel */
	populate_playlist_div(carouselData[selectedIndex]);
    
    angle += ( -360 / numPanels ) * increment;
    carousel.style[ '-webkit-transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';
    carousel.style[ 'transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';   
}