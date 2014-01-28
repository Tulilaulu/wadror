class Beer < ActiveRecord::Base
include RatingAverage
	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters,-> { uniq }, through: :ratings, source: :user

 validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }
	validates :name, presence: true
	def to_s
		return self.name+" by "+self.brewery.name
	end

end
