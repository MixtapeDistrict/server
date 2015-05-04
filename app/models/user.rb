class User < ActiveRecord::Base
	has_many :playlists, dependent: :destroy

	has_many :ratings, dependent: :destroy
	has_many :media, dependent: :destroy

	has_many :album_ratings, dependent: :destroy 
	has_many :albums, :through => :album_ratings

	has_many :comments, dependent: :destroy

	has_many :followers, dependent: :destroy
	
	def self.updateimage(user, img)
		filenamebase = Time.now().strftime("%Y%m%d%H%M%S")+'___'+img.original_filename
		File.open(Rails.root.join('app/assets/images', 'userimage', filenamebase), 'wb') do |file|
			file.write(img.read)
		user = User.where(id: user).first
		user.image_path = filenamebase
		user.save
		end
		File.open(Rails.root.join('public/assets/images', 'userimage', filenamebase), 'wb') do |file|
			file.write(img.read)
		end
	end
end
