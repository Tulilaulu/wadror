class User < ActiveRecord::Base
include RatingAverage
	has_secure_password
        validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }
        validates :password,
                       length: { minimum: 3 }
	validates_format_of :password, :with => /[A-Z]/,
	:message => "password must contain at least one capital letter and one number."
	validates_format_of :password, :with => /\d/,
	:message => "password must contain at least one capital letter and one number."

	has_many :memberships, dependent: :destroy
	has_many :ratings, dependent: :destroy
	has_many :beer_clubs, through: :memberships
	has_many :beers, through: :ratings
end
