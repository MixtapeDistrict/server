class Comment < ActiveRecord::Base
	belongs_to :user
	has_many :album_comments
	has_many :profile_comments
	has_many :music_comments
	has_many :personal_comments
end
