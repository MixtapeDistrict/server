# The main container for our application.
#
# Responsibilities: Parses incoming requests
# to the server into an iframe and keeps
# the music player outside the iframe.
#
# Action => parse_route : connects routes to server.
#
# Modified at 18th May 2015.
#########################################################################

class MainController < ApplicationController
	LINK = "/home"
	
	def parse_route
		@link = LINK
		if(params[:request])
			@link = params[:request]
		end
		render :layout => false
	end
end
