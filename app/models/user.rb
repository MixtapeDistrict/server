class User < ActiveRecord::Base
	has_many :playlists, dependent: :destroy

	has_many :ratings, dependent: :destroy
	has_many :media, dependent: :destroy

	has_many :album_ratings, dependent: :destroy 
	has_many :albums, :through => :album_ratings

	has_many :comments, dependent: :destroy

	has_many :followers, dependent: :destroy
end
