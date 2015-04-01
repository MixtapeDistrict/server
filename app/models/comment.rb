class Comment < ActiveRecord::Base
	belongs_to :user

	has_one :album_comment
	has_one :profile_comment
	has_one :mudium_comment
	has_one :personal_comment
end
