class MediumComment < ActiveRecord::Base
	belongs_to :comment
	belongs_to :medium
end
