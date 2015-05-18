# The main container for our application.
# Modified at 2nd May 2015.
# Responsibilities: Parses incoming requests
# to the server into an iframe and keeps
# the music player outside the iframe.
class MainController < ApplicationController
	LINK = "/home"
	
	#Function to parse routes through the server
	def parse_route
		@link = LINK
		if(params[:request])
			@link = params[:request]
		end
		render :layout => false
	end
end
