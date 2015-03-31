class Album < ActiveRecord::Base
	has_many :album_ratings 
	has_and_belongs_to_many :musics
end
