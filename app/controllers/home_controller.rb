class HomeController < ApplicationController
	def showHome
		if(params.has_key?(:error)) 
			@error = params[:error]
		else
			@error = ""
		end
		# Initialize the user's session if it doesn't
		# already have one.
		if(session.has_key?("logged_in"))
			# If the user is logged in render the logged
			# in page
			if(session['logged_in'] == 1) 
				redirect_to action:"logged_in"
			end
		else
			# Initialize the session
			session['logged_in'] = 0
			session['user_id'] = 0
		end
	end

	def logged_in
		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to action:"showHome"
			end
		else
			redirect_to action:"showHome"
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
		# Check username exists or email is exists
		if(User.find_by(email:email)) 
			response += "emailExists"
		end
		if(User.find_by(username:username)) 
			response += "usernameExists"
		end
		# If response is empty, create the user
		if(response.empty?)
			User.create(username:username, email:email, password:password, image_path:'placeholder.gif')
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