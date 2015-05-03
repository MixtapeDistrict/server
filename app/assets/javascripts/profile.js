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

/** Allow submit in modal footer */
$('#submit-update').click(function(){
	$('.submit-update').submit();
});

$('#submit-track').click(function(){
	$('.submit-track').submit();
});

$('#submit-album').click(function(){
	$('.submit-album').submit();
});
