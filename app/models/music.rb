class Music < ActiveRecord::Base
	belongs_to :user 
	has_many :music_ratings 
	has_and_belongs_to_many :playlists
	has_and_belongs_to_many :albums 
end
