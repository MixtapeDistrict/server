class HomeController < ApplicationController
	def showHome
		if(params.has_key?(:error)) 
			@error = params[:error]
		else
			@error = ""
		end
		# Initialize the user's session if it doesn't
		# already have one.
		if(not session.has_key?("logged_in"))
			# Initialize the session
			session['logged_in'] = 0
			session['user_id'] = 0
		end
	end

	def sign_up
		# Retrieve the variables passed in
		username = params[:username]
		email = params[:email]
		password = params[:password]
		# Need to perform an action and respond
		# to AJAX request
		response = ""
		# Generate random default image for user.
		index = rand(0..3)
		files = ['yellow.jpg', 'blue.jpg', 'green.jpg', 'red.jpg']

		# Check username exists or email is exists
		if(User.find_by(email:email)) 
			response += "emailExists"
		end
		if(User.find_by(username:username)) 
			response += "usernameExists"
		end
		# If response is empty, create the user
		if(response.empty?)
			User.create(username:username, email:email, password:password, image_path:files[index], payment_email:email)
		end
		# Return the response to the AJAX script
		render :text => response
	end

	def sign_out
		# Log the user out
		session['logged_in'] = 0
		# Transfer controll to showHome
		redirect_to action:"showHome"
	end

	def login
		# Get the parameters passed 
		username = params[:username]
		password = params[:password]
		# Get the user trying to login 
		response = ""
		user = User.find_by(username:username)
		userEmail = User.find_by(email:username)
		if(user)
			# Check if this user has the password
			if(user.password == password)
				session['logged_in']=1
				session['user_id']=user.id
			else
				response+="error"
			end
		else 
			response += "error"
		end
		# If there was an error check if user entered email
		if(userEmail and not response.empty?)
			# Check if this user entered the current password
			if(userEmail.password == password)
				session['logged_in']=1
				session['user_id']=userEmail.id
				response =""
			else
				response+="error"
			end
		end
		render :text => response
	end
end