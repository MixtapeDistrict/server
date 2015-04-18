class HomeController < ApplicationController
	def showHome
	end

	def sign_up
		# Retrieve the variables passed in
		username = params[:username]
		email = params[:email]
		password = params[:password]
		# Need to perform an action and respond
		# to AJAX request
		response = ""
		# Check username exists or email is exists
		if(User.find_by(email:email)) 
			response += "emailExists"
		end
		if(User.find_by(username:username)) 
			response += "usernameExists"
		end
		# If response is empty, create the user
		if(response.empty?)
			User.create(username:username, email:email, password:password)
		end
		# Return the response to the AJAX script
		render :text => response
	end
end
