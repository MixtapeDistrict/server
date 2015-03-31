class Music < ActiveRecord::Base
	belongs_to :user 

	has_many :music_ratings 

	has_many :playlist_musics, dependent: :destroy
	has_many :playlists, :through => :playlist_musics

	has_many :music_albums, dependent: :destroy
	has_many :albums, :through => :music_albums
end
