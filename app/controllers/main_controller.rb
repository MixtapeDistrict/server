class MainController < ApplicationController
  LINK = "/home"
  def parse_route
  	@link = LINK
  	render :layout => false
  end
end
