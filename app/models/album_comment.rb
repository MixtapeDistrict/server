class AlbumComment < ActiveRecord::Base
	belongs_to :comment
	belongs_to :album 
end
