class Music < ActiveRecord::Base
	belongs_to :medium

	has_many :music_albums, dependent: :destroy
	has_many :albums, :through => :music_albums
	has_and_belongs_to_many :playlists
end
