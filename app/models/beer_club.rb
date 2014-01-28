class BeerClub < ActiveRecord::Base
	has_many :memberships
	has_many :users, through: :memberships
	def to_s
		return self.name+" in "+self.city
	end
end
