// TRACKS PICK SIMULATION: Won't be here when the database is connected
    
    //Suffle an int Array
    function shuffle(array) {
      var m = array.length, t, i;

      // While there remain elements to shuffle…
      while (m) {

        // Pick a remaining element…
        i = Math.floor(Math.random() * m--);

        // And swap it with the current element.
        t = array[m];
        array[m] = array[i];
        array[i] = t;
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

    // Simulates the las 100 tracks
    var track_id = range(1,100);

    //Select the first 24 elements of the random array
    var rand_tracks = shuffle(track_id).slice(0,24);

    //Test for the grind
    var tracks = '{"tracks":[' +
    '{"cover":"common/'+ rand_tracks[0]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[1]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[2]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[3]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[4]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[5]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[6]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[7]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[8]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[9]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[10]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[11]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[12]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[13]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[14]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[15]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[16]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[17]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[18]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[19]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[20]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[21]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[22]+'.jpg"},' +
    '{"cover":"common/'+ rand_tracks[23]+'.jpg"}]}';

// END TRACKS PICK SIMULATION: Won't be here when the database is connected


// Create the grind
obj = JSON.parse(tracks);

html='';
track_info='';
// Create each individual track: index used to provide example, will be replaced with the actual info.
for (var i=0; i<24 ; i++){
    track_info = 'data-title="    Track Title '+(i+1)+'" data-artist="    Artist '+(i+1)+'" data-len="    Duration: '+
                 (i+1)+':00" data-album="    Album '+(i+1)+'" data-rating="    '+(i+1)+'/'+(i+1)+'"'
    html += '<div class="element" '+track_info+'><img id="track" class="col-md-2 img-thumbnail" alt="" src="../'+ obj.tracks[i].cover +'"></div>';
      
};
// Put all racks in place
$('.grind').append(html); 

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

        // TRACKS PICK SIMULATION: Won't be here when the database is connected
        track_id = range(1,100);
        rand_tracks = shuffle(track_id).slice(0,24);

        tracks = '{"tracks":[' +
        '{"cover":"common/'+ rand_tracks[0]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[1]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[2]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[3]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[4]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[5]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[6]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[7]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[8]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[9]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[10]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[11]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[12]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[13]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[14]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[15]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[16]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[17]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[18]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[19]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[20]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[21]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[22]+'.jpg"},' +
        '{"cover":"common/'+ rand_tracks[23]+'.jpg"}]}';
        
        // END TRACKS PICK SIMULATION: Won't be here when the database is connected

        // Replace with new tracks
        obj = JSON.parse(tracks);

        html='<div class="row grind">';
        // Create each individual track: index used to provide example, will be replaced with the actual info.
        for (var i=0; i<24 ; i++){
            track_info = 'data-title="    Track Title '+(i+1)+'" data-artist="    Artist '+(i+1)+'" data-len="    Duration: '+
                         (i+1)+':00" data-album="    Album '+(i+1)+'" data-rating="    '+(i+1)+'/'+(i+1)+'"'
            html += '<div class="element" '+track_info+'><img id="track" class="col-md-2 img-thumbnail" alt="" src="../'+ obj.tracks[i].cover +'"></div>';
        };
        html += '</div>'
        $('.grind').replaceWith(html); 
	});
	
	// Do Carousel
	// Will pull this from server. Static for now.
    
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