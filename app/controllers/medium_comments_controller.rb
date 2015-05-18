# Scaffold generated to interact with comments on the website.
#
# Modified at: 18th May 2015
#########################################################################

class MediumCommentsController < ApplicationController
	before_action :set_medium_comment, only: [:show, :edit, :update, :destroy]

	# GET /medium_comments
	# GET /medium_comments.json
	def index
		@medium_comments = MediumComment.all
	end

	# GET /medium_comments/1
	# GET /medium_comments/1.json
	def show
	end

	# GET /medium_comments/new
	def new
		@medium_comment = MediumComment.new
	end

	# GET /medium_comments/1/edit
	def edit
	end

	# POST /medium_comments
	# POST /medium_comments.json
	def create
		@medium_comment = MediumComment.new(medium_comment_params)

		respond_to do |format|
			if @medium_comment.save
				format.html { redirect_to @medium_comment, notice: 'Medium comment was successfully created.' }
				format.json { render action: 'show', status: :created, location: @medium_comment }
			else
				format.html { render action: 'new' }
				format.json { render json: @medium_comment.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /medium_comments/1
	# PATCH/PUT /medium_comments/1.json
	def update
		respond_to do |format|
			if @medium_comment.update(medium_comment_params)
				format.html { redirect_to @medium_comment, notice: 'Medium comment was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @medium_comment.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /medium_comments/1
	# DELETE /medium_comments/1.json
	def destroy
		@medium_comment.destroy
		respond_to do |format|
			format.html { redirect_to medium_comments_url }
			format.json { head :no_content }
		end
	end

	private
    
	# Use callbacks to share common setup or constraints between actions.
	def set_medium_comment
		@medium_comment = MediumComment.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def medium_comment_params
		params.require(:medium_comment).permit(:comment_id, :medium_id)
	end
end
