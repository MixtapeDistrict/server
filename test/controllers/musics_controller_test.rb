# Unit tests for things the music controllerS does:
# Allows users to upload music,  download music ,play music
# delete music & edit music.
# Things like download and playing are tested in usability
# testing and in the web browser. Here the database functionality
# is mainly testing.

# Unit tests for the musics controller
class MusicsControllerTest 
  # Tests whether the user can upload music
  def upload_music
  	puts "Testing music upload (Only the database version, file version tested manually)"
  	# Create a dummy user
  	user = User.create
  	# Store the id for future use
  	@id = user.id
  	# Assume the user has uploaded a dummy file
  	# Do exactly what the music controller will do 
  	medium = Medium.create
  	medium.user = user
  	medium.music = Music.create
  	@medium_id = medium.id
  	# Persist
  	medium.save
  	# Ensure this song belongs to this user and it was created
  	raise "Music upload failed " unless medium and medium.music
  	puts "Music upload test successfull."
  end

  # Tests whether the users can edit their music 
  def edit_music
  	puts "Testing music editing"
  	# Assume the user wants to change the title of their song
  	# Find the user who wants to edit their track
  	user = User.find_by(id:@id)
  	# Now find the song this user uploaded earlier
  	medium = Medium.find_by(id:@medium_id)
  	new_title = "Hello"
  	medium.title = new_title
  	medium.save
  	# Ensure the user edited the information of their own track
  	raise "Music editing failed " unless medium.id == @medium_id and medium.user_id == @id
  	puts "Music editing passed"
  end

  # Ensure the users can delete their music 
  def delete_music
  	puts "Testing music deleting"
  	# Going to delete all the music of this user
  	mediums = Medium.where(user_id:@id)
  	for medium in mediums
  		medium.music.destroy
  		medium.destroy
  	end
  	# Ensure the user's music got deleted 
  	raise "Music deletion failed " unless not Medium.find_by(user_id:@id)
  	puts "Music deletion passed"
  end

  # Clean up
  def clean_up
  	puts "Cleaning up..."
  	# Remove all their tracks
  	mediums = Medium.where(user_id:@id)
  	for medium in mediums
  		medium.music.destroy
  		medium.destroy7
  	end
  	# Remove the user from the database
  	User.find_by(id:@id).destroy
  end

  # A class method to run the unit test case
  def self.run
  	mct = MusicsControllerTest.new
  	puts "<--------------------- Running unit tests for music controller ---------------->"
  	mct.upload_music
  	mct.edit_music
  	mct.delete_music
  	mct.clean_up
  	puts "<---------------------- All unit tests for music controller passed ------------->"
  end
end
