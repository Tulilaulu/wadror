class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	def average_rating
		return self.ratings.average('score').to_s
	end

end
