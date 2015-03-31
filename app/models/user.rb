class User < ActiveRecord::Base
	has_many :playlists
	has_many :music_ratings
	has_many :musics 
	has_many :album_ratings 
	has_many :comments
	has_many :followers
	has_one :profile
end
