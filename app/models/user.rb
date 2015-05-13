class User < ActiveRecord::Base
	has_one :playlist

	has_many :ratings, dependent: :destroy
	has_many :media, dependent: :destroy

	has_many :album_ratings, dependent: :destroy 
	has_many :albums, :through => :album_ratings

	has_many :comments, dependent: :destroy

	has_many :followers, dependent: :destroy
	
	#Function for changing user profile images
	def self.updateimage(user, img)
		#Assign unique filename prefix (Time uploaded to the second)
		filenamebase = Time.now().strftime("%Y%m%d%H%M%S")+'___'+img.original_filename
		
		#Upload file to development location
		File.open(Rails.root.join('app/assets/images', 'userimage', filenamebase), 'wb') do |file|
			file.write(img.read)
			
			#Assign the image to the correct user
			user = User.where(id: user).first
			user.image_path = filenamebase
			user.save
		end
		
		#Upload the image to the production location
		File.open(Rails.root.join('public/assets/images', 'userimage', filenamebase), 'wb') do |file|
			file.write(img.read)
		end
	end
end
