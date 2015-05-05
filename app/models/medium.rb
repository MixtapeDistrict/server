class Medium < ActiveRecord::Base
	belongs_to :user

	has_many :ratings, dependent: :destroy

	has_many :medium_comments, dependent: :destroy

	has_one :music
	
	def self.createnew(uid, title, fpath, ipath, type)
		Medium.create(user_id: uid, title: title, file_path: fpath, image_path: ipath, media_type: type)
	end
	
	def self.getusertracks(uid)
		return Medium.where(user_id: uid)
	end
end
