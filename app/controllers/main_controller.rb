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
