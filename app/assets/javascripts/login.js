/* A javascript file which handles signing in */
function sign_in() {
	var username = document.getElementById('logIn-username').value;
	var password = document.getElementById('logIn-password').value;

	/* Communicate with the server and check if this is a valid sign up */
	var xmlhttp;
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			response = xmlhttp.responseText;
			if(response.indexOf("error") >= 0) {
				document.getElementById('login-message').innerHTML = "Invalid username/password";
			}
			else {
				location.reload();
			}
		}
	}
	var request = "/login?username="+username+"&password="+password;
	xmlhttp.open("post", request, true);
	xmlhttp.send();
}

function clearLogin() {
	document.getElementById('login-message').innerHTML = "";
}
