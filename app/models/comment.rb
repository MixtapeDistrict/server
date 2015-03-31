class Comment < ActiveRecord::Base
	belongs_to :user
	has_many :album_comments, dependent: :destroy
	has_many :profile_comments, dependent: :destroy
	has_many :music_comments, dependent: :destroy
	has_many :personal_comments, dependent: :destroy
end
