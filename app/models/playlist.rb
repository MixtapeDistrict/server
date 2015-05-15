class Playlist < ActiveRecord::Base
	belongs_to :user 
	has_many :musics
	has_and_belongs_to_many :musics
end
