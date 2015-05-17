/* A javascript file which handles signing in */

function validate2(username, email) {
	var regex = /^[A-Za-z0-9]{6,30}$/i; //Regex for valid usernames
	var valid = true;
	var regex2 = /^[A-Za-z0-9_.-]+@[A-Za-z0-9]+\.[A-Za-z0-9.]*[A-Za-z]$/i; //Regex for valid emails
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

//Validate emails for payments
function validate_payment_email() {
	console.log()
	var valid = true;
	var regex = /^[A-Za-z0-9_.-]+@[A-Za-z0-9]+\.[A-Za-z0-9.]*[A-Za-z]$/i; //Regex for emails again
	var email = document.getElementById('payment-email').value;
	if(!regex.test(email)) {
		valid = false;
		document.getElementById('payment_email_outcome').innerHTML = "Invalid email";
	}
	return valid;
}

//Get rid of the errormessage once the user corrects
function clearErrorMessage() {
	document.getElementById('name_outcome').innerHTML = "";
	document.getElementById('email_outcome').innerHTML = "";
	document.getElementById('payment_email_outcome').innerHTML = "";
}


//Perform validations on the new details entered by the user when updating their profile
function update_profile() {
	var username = document.getElementById('name').value;
	var email = document.getElementById('email').value;
	var result = validate2(username, email);
	return result;
}

// TRACKS PICK SIMULATION: Won't be here when the database is connected
	//This remains here for posterity
    // Make an Array form start to end of size(end-start+1)
    function range(start, end) {
        var array = [];
        for (var i = start; i <= end; i++) {
            array.push(i);
        }
        return array;
    }

// Enable these functionalities when page is loaded   

$(document).ready(function(){
	/** Allow submit in modal footer */
	$('#submit-update').click(function(){
		$('.submit-update').submit();
	});
	/** Allow submit in modal footer */
	$('#submit-album').click(function(){
		$('.submit-album').submit();
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

	/* Initialize file upload plugin for track image update */
	$(".editImage").fileinput({
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