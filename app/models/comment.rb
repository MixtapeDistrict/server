class Comment < ActiveRecord::Base
	belongs_to :user

	has_one :album_comment
	has_one :profile_comment
	has_one :medium_comment
	has_one :personal_comment
end
