# Unit tests for things the Playlist
# Music controller does
class PlaylistMusicsControllerTest 

  # Tests whether the user can 
  # create a playlist 
  def create
  	puts "Playlist creation test."
  	# Create a dummy user
  	user = User.create()
  	raise "Failed to create user" unless user
  	# Create a playlist for this user
  	user.playlist = Playlist.create()
  	# Check whether this playlist was created
  	raise "Failed to create user playlist" unless user.playlist
  	# Store the dummy's users id for future use
  	@id = user.id
  	puts "Playlist creation test passed."
  end

  # Tests whether the user can read
  # their playlist
  def read
  	puts "Playlist read test."
  	# Find the dummy user 
  	user = User.find_by(id:@id)
  	raise "Failed to read user" unless user
  	# Find the playlist for this user
  	playlist = user.playlist
  	raise "Failed to read user playlist" unless user.playlist
  	puts "Playlist read test passed. "
  end

  # Tests whether the user can update i.e:
  # Add music and delete music from their playlist
  def update
  	puts "Add to playlist test"
  	# Find the dummy user
  	user = User.find_by(id:@id)
  	raise "Failed to find user" unless user
  	# Find the playlist for this user
  	playlist = user.playlist
  	raise "Failed to find user's playlist" unless playlist
  	medium = Medium.create
  	medium.user = user
  	medium.save
  	# Now create a new song
  	medium.music = Music.create
  	song = medium.music
  	# Add the song to the playlist
  	playlist.musics.push song
  	# Persist
  	playlist.save
  	# Check whether the song was added to the playlist
  	raise "The song failed to add to the playlist" unless playlist.musics.length == 1
  	# Now delete the song from the database, as if the owner deleted it
  	Music.find_by(id:song.id).destroy
  	Medium.find_by(id:medium.id).destroy
  	playlist = User.find_by(id:@id).playlist
   	# Now ensure the song also got deleted from the user's playlist
  	raise "The song failed to remove from the playlist once the owner destroyed it." unless playlist.musics.length == 0
  	puts "Add to playlist test passed"
  	# Now Ensure the user can delete the song from their playlist
  	puts "Remove from playlist test"
  	medium = Medium.create
  	medium.user = user
  	medium.save
  	song = medium.music = Music.create
  	# Add the song to user user's playlist
  	playlist.musics.push song
  	playlist.save
  	user.save
  	raise "Failed to add song to the playlist" unless playlist.musics.length == 1
  	# Now delete the song from the user's playlist
  	playlist.musics.delete(song)
  	# Persists
  	playlist.save
  	user.save
  	# Ensure the song was removed from the playlist
  	raise "Failed to remove song from user's playlist" unless playlist.musics.length == 0
  	puts "Remove from playlist test passed"
  end

  # Cleans up after the unit test is finished
  def clean_up
  	puts "Cleaning up..."
  	# Find the user inside the database
  	user = User.find_by(id:@id)
  	user.playlist.destroy
	mediums = Medium.where(user_id:@id)
	for medium in mediums
		medium.music.destroy
		medium.destroy
	end


  	# Destroy the user
  	user.destroy
  	puts "Finished...."
  end

  # A class method which can be called to run this unit test
  def self.run
  	puts "<--------------------- Running unit tests for playlists ---------------->"
  	# Create a new test object
  	pmct = PlaylistMusicsControllerTest.new
  	# First run the create test
  	pmct.create
  	# Then the update test
  	pmct.update
  	# Clean up after the unit test finishes
  	pmct.clean_up
  	puts "<----------------------ALL UNIT TESTS PASSED-------------------------->"
  end
end
