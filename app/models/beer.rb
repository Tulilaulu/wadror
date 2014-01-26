class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def to_s
		return self.name+" by "+self.brewery.name
	end

	def average_rating
		return self.ratings.average('score').to_s
	end
end
