/* A javascript file which handles signing in */
		document.getElementById('name_outcome').innerHTML = "Invalid username";

function update_profile() {
	var username = document.getElementById('name').value;
	var email = document.getElementById('email').value;
	if(!validate(username, email)) {
		return false;
	}
	return false;
}

// You should comment on what is allowed in the regex string...
function validate(username, email) {
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
