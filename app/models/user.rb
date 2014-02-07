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

  def favorite_beer
    return nil if ratings.empty?  
    ratings.order(score: :desc).limit(1).first.beer
  end
  def favorite_style
    return nil if ratings.empty?
    @styles = ratings.map {|rating| rating.beer.style}.uniq  
    favorite = nil
    favoritescore = 0
    for style in @styles
	ratingsum = ratings.find_all{|rating| rating.beer.style == style }.inject(0){|sum,rating| sum + rating.score }	
	ratingscore = ratingsum / ratings.find_all{|rating| rating.beer.style == style}.count.to_f
	if (favoritescore < ratingscore)
		favoritescore = ratingscore
		favorite = style
	end
    end
    return favorite
  end
  def favorite_brewery
    return nil if ratings.empty?  
    @breweries = ratings.map {|rating| rating.beer.brewery}.uniq  
    favorite = nil
    favoritescore = 0
    for brewery in @breweries
	ratingsum = ratings.find_all{|rating| rating.beer.brewery == brewery }.inject(0){|sum,rating| sum + rating.score }	
	ratingscore = ratingsum / ratings.find_all{|rating| rating.beer.brewery == brewery}.count.to_f
	if (favoritescore < ratingscore)
		favoritescore = ratingscore
		favorite = brewery
	end
    end
    return favorite
  end
end
