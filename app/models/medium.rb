class Medium < ActiveRecord::Base
	belongs_to :user

	has_many :ratings, dependent: :destroy

	has_many :medium_comments, dependent: :destroy

	has_one :music
end
