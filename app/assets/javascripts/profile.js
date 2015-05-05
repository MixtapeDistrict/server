/* A javascript file which handles signing in */

// You should comment on what is allowed in the regex string...
function validate2(username, email) {
	var regex = /^[A-Za-z0-9]{6,30}$/i;
	var valid = true;
	var regex2 = /^[A-Za-z0-9_.-]+@[A-Za-z0-9]+\.[A-Za-z0-9.]*[A-Za-z]$/i;
	if(!regex.test(username)) {
		valid = false;
		document.getElementById('name_outcome').innerHTML = "Invalid username";
	}
	if(!regex2.test(email)) {
		valid = false;
		document.getElementById('email_outcome').innerHTML = "Invalid email";
	}
	return valid;
}

function clearErrorMessage() {
	document.getElementById('name_outcome').innerHTML = "";
	document.getElementById('email_outcome').innerHTML = "";
}



function update_profile() {
	var username = document.getElementById('name').value;
	var email = document.getElementById('email').value;
	var result = validate2(username, email);
	return result;
}

// TRACKS PICK SIMULATION: Won't be here when the database is connected

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

    //Test for the grind
    var tracks = '{"tracks":[' +
    '{"cover":"common/'+ track_id[0]+'.jpg"},' +
    '{"cover":"common/'+ track_id[1]+'.jpg"},' +
    '{"cover":"common/'+ track_id[2]+'.jpg"},' +
    '{"cover":"common/'+ track_id[3]+'.jpg"},' +
    '{"cover":"common/'+ track_id[4]+'.jpg"},' +
    '{"cover":"common/'+ track_id[5]+'.jpg"},' +
    '{"cover":"common/'+ track_id[6]+'.jpg"},' +
    '{"cover":"common/'+ track_id[7]+'.jpg"},' +
    '{"cover":"common/'+ track_id[8]+'.jpg"},' +
    '{"cover":"common/'+ track_id[9]+'.jpg"},' +
    '{"cover":"common/'+ track_id[10]+'.jpg"},' +
    '{"cover":"common/'+ track_id[11]+'.jpg"},' +
    '{"cover":"common/'+ track_id[12]+'.jpg"}]}';

        //Test for the grind
    var albums = '{"albums":[' +
    '{"cover":"common/'+ track_id[13]+'.jpg"},' +
    '{"cover":"common/'+ track_id[14]+'.jpg"},' +
    '{"cover":"common/'+ track_id[15]+'.jpg"},' +
    '{"cover":"common/'+ track_id[16]+'.jpg"},' +
    '{"cover":"common/'+ track_id[17]+'.jpg"},' +
    '{"cover":"common/'+ track_id[18]+'.jpg"},' +
    '{"cover":"common/'+ track_id[19]+'.jpg"},' +
    '{"cover":"common/'+ track_id[20]+'.jpg"},' +
    '{"cover":"common/'+ track_id[21]+'.jpg"},' +
    '{"cover":"common/'+ track_id[22]+'.jpg"},' +
    '{"cover":"common/'+ track_id[23]+'.jpg"},' +
    '{"cover":"common/'+ track_id[24]+'.jpg"},' +
    '{"cover":"common/'+ track_id[25]+'.jpg"}]}';

        //Test for the grind
    var collaborators = '{"collaborators":[' +
    '{"cover":"common/'+ track_id[26]+'.jpg"},' +
    '{"cover":"common/'+ track_id[27]+'.jpg"},' +
    '{"cover":"common/'+ track_id[28]+'.jpg"},' +
    '{"cover":"common/'+ track_id[29]+'.jpg"},' +
    '{"cover":"common/'+ track_id[30]+'.jpg"},' +
    '{"cover":"common/'+ track_id[31]+'.jpg"},' +
    '{"cover":"common/'+ track_id[32]+'.jpg"},' +
    '{"cover":"common/'+ track_id[33]+'.jpg"},' +
    '{"cover":"common/'+ track_id[34]+'.jpg"},' +
    '{"cover":"common/'+ track_id[35]+'.jpg"},' +
    '{"cover":"common/'+ track_id[36]+'.jpg"},' +
    '{"cover":"common/'+ track_id[37]+'.jpg"},' +
    '{"cover":"common/'+ track_id[38]+'.jpg"}]}';


// END TRACKS PICK SIMULATION: Won't be here when the database is connected


// Create the grind
obj = JSON.parse(tracks);

html='<div class="tab-content row">';
// Create each individual track: index used to provide example, will be replaced with the actual info.
//for (var i=0; i<12 ; i++){
//    var img = '<div class="col-md-6"><img id="content-img"  alt="" src="../'+ obj.tracks[i].cover +'"></div>'
//    var name = '<p class="h4 row info track-name">Track name</p>'
//    var coll = '<p class="row info track-coll">(Collaborator)</p>'
//    var album = '<p class="row info track-album">Album</p>'
//    var duration = '<p class="row info track-duration">3:00</p>'
//    var info =  '<div class="col-md-6 content-info">'+name+coll+album+duration+'</div>';
//    html += '<div class="element col-md-4">'+img+info+'</div>';
//};
//html+='</div><div class="row track-req"><button type="button" class="btn btn-default more center-block">More Tracks</button></div>'

$('#tracks').append(html);

// Create the grind
obj = JSON.parse(albums);

html='<div class="tab-content row">';

for (var i=0; i<12 ; i++){
    var img = '<div class="col-md-6"><img id="content-img"  alt="" src="../'+ obj.albums[i].cover +'"></div>'
    var name = '<p class="h4 row info album-name">Album name</p>'
    var coll = '<p class="row info album-coll">(Collaborator)</p>'
    var year = '<p class="row info album-year">2012</p>'
    var number = '<p class="row info album-number">'+(i+1)+' Tracks</p>'
    var info =  '<div class="col-md-6 content-info">'+name+coll+year+number+'</div>';
    html += '<div class="element col-md-4">'+img+info+'</div>';
};
// Create each individual track: index used to provide example, will be replaced with the actual info.
html+='</div>'


$('.album-preview').before(html); 

// Create the grind
obj = JSON.parse(collaborators);

html='<div class="tab-content row">';

for (var i=0; i<12 ; i++){
    var img = '<div class="col-md-6"><img id="content-img"  alt="" src="../'+ obj.collaborators[i].cover +'"></div>'
    var name = '<p class="h4 row info coll-name">Collaborator name</p>'
    var projects = '<p class="row info projects"><span class="proj-num">'+i+'<span> projects</p>'
    var info =  '<div class="col-md-6 content-info">'+name+projects+'</div>';
    html += '<div class="element col-md-4">'+img+info+'</div>';
};
html+='</div>';

$('#collaborators').append(html); 


// Enable these functionalities when page is loaded   

$(document).ready(function(){
	/** Allow submit in modal footer */
	$('#submit-update').click(function(){
		$('.submit-update').submit();
	});
	/** Allow submit in modal footer */
	$('#submit-track').click(function(){
		$('.submit-track').submit();
	});
	/** Allow submit in modal footer */
	$('#submit-album').click(function(){
		$('.submit-album').submit();
	});

	$('.more').click(function(){

        tracks = '{"tracks":[' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"},' +
        '{"cover":"common/'+ track_id[ Math.floor(Math.random() * 100)]+'.jpg"}]}';
        
        obj = JSON.parse(tracks);

        html='';
        // Show more tracks in profile.
        for (var i=0; i<12 ; i++){
            var img = '<div class="col-md-6"><img id="content-img"  alt="" src="../'+ obj.tracks[i].cover +'"></div>'
            var name = '<p class="h4 row info track-name">Track name</p>'
            var coll = '<p class="row info track-coll">(Collaborator)</p>'
            var album = '<p class="row info track-album">Album</p>'
            var duration = '<p class="row info track-duration">3:00</p>'
            var info =  '<div class="col-md-6 content-info">'+name+coll+album+duration+'</div>';
            html += '<div class="element col-md-4">'+img+info+'</div>';
        };
        
        // Put all tracks in place
        $('.more').before(html);
    });	

	/*Initializers as specified in pluging page https://github.com/kartik-v/bootstrap-fileinput */
	/* Initialize file upload pluging for profile image */
	$("#image").fileinput({
		previewFileType: "image",
		allowedFileTypes: ['image'],
		previewSettings:{ image: {width: "90%", height: "160px"}},
		browseClass: "btn btn-success",
		browseLabel: " Pick Image",
		browseIcon: '<i class="glyphicon glyphicon-picture"></i>',
		removeClass: "btn btn-danger",
		removeLabel: "Delete",
		removeIcon: '<i class="glyphicon glyphicon-trash"></i>',
		showUpload: false,
	});
	/* Initialize file upload pluging for track image upload */
	$("#track-img").fileinput({
		previewFileType: "image",
		allowedFileTypes: ['image'],
		previewSettings:{ image: {width: "90%", height: "160px"}},
		browseClass: "btn btn-success",
		browseLabel: " Pick Image",
		browseIcon: '<i class="glyphicon glyphicon-picture"></i>',
		removeClass: "btn btn-danger",
		removeLabel: "Delete",
		removeIcon: '<i class="glyphicon glyphicon-trash"></i>',
		showUpload: false,
	});
	/* Initialize file upload pluging for track file upload */
	$("#track-file").fileinput({
		previewFileType: "audio",	
		allowedFileTypes: ['audio'],
		browseClass: "btn btn-info",
		browseLabel: " Pick MP3",
		browseIcon: '<i class="glyphicon glyphicon-music"></i>',
		removeClass: "btn btn-danger",
		removeLabel: "Delete",
		removeIcon: '<i class="glyphicon glyphicon-trash"></i>',
		showUpload: false,
	});
	/* Initialize file upload pluging for album image upload */
	$("#album-image").fileinput({
		previewFileType: "image",
		allowedFileTypes: ['image'],		
		previewSettings:{ image: {width: "90%", height: "160px"}},
		browseClass: "btn btn-success",
		browseLabel: " Pick Image",
		browseIcon: '<i class="glyphicon glyphicon-picture"></i>',
		removeClass: "btn btn-danger",
		removeLabel: "Delete",
		removeIcon: '<i class="glyphicon glyphicon-trash"></i>',
		showUpload: false,
	});

});