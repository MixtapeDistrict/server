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

			track_info = 'Title: ' + songs[rand].childNodes[0].childNodes[0].nodeValue + 
			             '<br>Artist: <a href="/other_profile?id='+songs[rand].childNodes[3].childNodes[0].nodeValue+'">' + songs[rand].childNodes[2].childNodes[0].nodeValue +
			             '</a><br>Album: ' + songs[rand].childNodes[6].childNodes[0].nodeValue +
			             '<br>Plays: ' + songs[rand].childNodes[8].childNodes[0].nodeValue +
			             '<br>Ratings: ' + songs[rand].childNodes[9].childNodes[0].nodeValue + '/5';
			 html += '<div class="element"><img id="track" class="col-md-2 img-thumbnail" alt="" src="'+songs[rand].childNodes[4].childNodes[0].nodeValue+'"><div class="grid_description">'+track_info+'</div></div>';
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
			
        	track_info = 'Title: ' + songs[rand].childNodes[0].childNodes[0].nodeValue + 
			             '<br>Artist: <a href="/other_profile?id='+songs[rand].childNodes[3].childNodes[0].nodeValue+'">' + songs[rand].childNodes[2].childNodes[0].nodeValue +
			             '</a><br>Album: ' + songs[rand].childNodes[6].childNodes[0].nodeValue +
			             '<br>Plays: ' + songs[rand].childNodes[8].childNodes[0].nodeValue +
			             '<br>Ratings: ' + songs[rand].childNodes[9].childNodes[0].nodeValue + '/5';
			 html += '<div class="element"><img id="track" class="col-md-2 img-thumbnail" alt="" src="'+songs[rand].childNodes[4].childNodes[0].nodeValue+'"><div class="grid_description">'+track_info+'</div></div>';
		}
	}
	html += '</div>'
	/* Replace the grind HTML with the HTML this function generates. */
	/* Put all racks in place */
	$('.grind').replaceWith(html);
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
 
    var data=[];

    for (var i=0; i<10 ; i++){
        data.push(''+obj.tracks[i].cover +'');
    };

	doCarousel(data);

});

// Carousel JavaScript

// Created using http://desandro.github.io/3dtransforms/docs/carousel.html as a tutorial/guide
// I refactored and revamped just about all code from there, but it is possible a few variable names are the same

var PANEL_SIZE = 130;
var TO_RADIANS = Math.PI/180;
var BACKFACE_INVISIBLE = true;

// Creates a Carousel from an Array 
function doCarousel(data){
    var spinner = $("#carousel");
    var interval = 360/data.length;
    var r = PANEL_SIZE/(Math.tan((interval/2)*TO_RADIANS));
    for(var i = 0 ; i < data.length ; i++) {
        var newElement = $("<img src=\"../"+data[i]+"\">");
        var num = interval*i;
        newElement.css("transform","rotateY( " + num + "deg ) translateZ( "+r+"px )");
        
        var backfaceVisibility = BACKFACE_INVISIBLE ? "hidden" : "visible";
        newElement.css("-webkit-backface-visibility",backfaceVisibility);
        newElement.css("backface-visibility",backfaceVisibility);
        spinner.append(newElement);
    }
}

// Makes the images on the carousel spin, updating the css
var angle = 0;
function galleryspin(sign) {
    var carousel = document.querySelector('#carousel');
    var numPanels = carousel.children.length;
    var increment = sign ? -1 : 1;
    
    angle += ( -360 / numPanels ) * increment;
    carousel.style[ '-webkit-transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';
    carousel.style[ 'transform' ] = 'translateZ( -288px ) rotateY(' + angle + 'deg)';   
}