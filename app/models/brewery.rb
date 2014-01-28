class Brewery < ActiveRecord::Base
include RatingAverage
l = lambda{||Time.now.year}
 validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: l.call,
                                    only_integer: true }
 validates :name, presence: true
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
end
