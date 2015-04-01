class Music < ActiveRecord::Base
	belongs_to :medium

	has_many :music_albums, dependent: :destroy
	has_many :albums, :through => :music_albums

	has_many :playlist_musics, dependent: :destroy
	has_many :playlists, :through => :playlist_musics
end
