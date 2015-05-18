/* A javascript file which handles signing in */
function sign_in() {
	var username = document.getElementById('logIn-username').value;
	var password = document.getElementById('logIn-password').value;

	/* Communicate with the server and check if this is a valid sign up */
	var xmlhttp;
	
	//Handle different browsers using different standards... Looking at you IE
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			response = xmlhttp.responseText;
			//Check if the login was valid
			if(response.indexOf("error") >= 0) {
				//Invalid login
				document.getElementById('login-message').innerHTML = "Invalid username/password";
			}
			else {
				//Valid login, replace page contents with the 'logged in' version
				document.getElementById('replace').innerHTML = "\
    <li>\
      <form class=\"navbar-form navbar-left\" role=\"search\" method=\"get\" action=\"/search\">\
      <div class=\"form-group\">\
	    <input type=\"text\" class=\"form-control\" style=\"width:300px;\"  placeholder=\"Search for tracks, profiles or genres\" name=\"search\" required/>\
      	<input type=\"submit\" class=\"navbar-btn btn btn-search btn-default hidden-xs\" value=\"Go!\"/>\
      </div></form></li>\
	<li class=\"dropdown\">\
      <a href=\"/user_profile\" class=\"dropdown-toggle\" data_toggle=\"dropdown\" role=\"button\" aria_expanded=\"true\"><img src='assets/person.png' style='width:20px; height:22px;'></a>\
    </li>\
    <li class=\"dropdown\">\
      <form action=\"/sign_out\" method=\"post\">\
        <button type=\"submit\" class=\"btn profile-btn btn-danger log-out\">Logout</button>\
      </form>\
    </li>";
         
         location.reload();
			}
		}
	}
	var request = "/login?username="+username+"&password="+password;
	xmlhttp.open("post", request, true);
	xmlhttp.send();
}

/* Clears the login message divider when form is 
 * bought into focus.
 */
function clearLogin() {
	document.getElementById('login-message').innerHTML = "";
}
