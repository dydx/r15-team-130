class Conference < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode

  validates :dateandtime, :presence => true, :allow_blank => false
end
