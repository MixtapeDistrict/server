class Album < ActiveRecord::Base
	has_many :album_ratings, dependent: :destroy 
	has_many :users, :through => :album_ratings

	has_many :music_albums
end
