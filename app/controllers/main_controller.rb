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
