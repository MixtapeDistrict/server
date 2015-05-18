# Controller that manages the homepage functionality.
#
# Responsibilities: Intializing sessions,
# and session parameters. Also responsible
# for signing users up and logging them in.
#
# Actions(functions/methods):
# => showHome : creates a new user session and opens homepage.
# => sign_up : user Ajax to sign a user to the system.
# => sign_out : user logs out of the system.
# => login : enables user login.
#
# Modified at 17th May 2015.
################################################################

class HomeController < ApplicationController

	# Initializes session & renders homepage
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

	# Responsible for signing the user up
	# Called using AJAX.
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
		
		#Find the user
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

	# Responsible for signing the user out.
	def sign_out
		# Log the user out
		session['logged_in'] = 0
		
		# Transfer controll to showHome
		redirect_to action:"showHome"
	end

	# Responsible for signing the user in.
	# Also called using AJAX.
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