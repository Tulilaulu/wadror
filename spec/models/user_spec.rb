require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "or with a password that is too short" do
    user = User.create username:"Pekka", password:"E4", password_confirmation:"E4" 

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
   end

  it "or with a letters-only password" do
    user = User.create username:"Pekka", password:"secret", password_confirmation:"secret" 

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }
    it "the user is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end


    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
 describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end
  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_style).to eq("Lager")
    end

    it "is the one with highest average rating if several rated" do
      create_beer_with_rating_and_style(20, "Lager", user)
      create_beer_with_rating_and_style(10, "IPA", user)
      create_beer_with_rating_and_style(25, "IPA", user)
      create_beer_with_rating_and_style(40, "Porter", user)
      create_beer_with_rating_and_style(10, "Porter", user)
      expect(user.favorite_style).to eq("Porter")
    end
  end
  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the one with highest average rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      brewery=FactoryGirl.create(:brewery, name:"Random")
      create_beers_with_ratings(10, 20, 15, 7, 20, user, brewery)
      expect(user.favorite_brewery.to_s).to eq("Random")
    end
  end
    def create_beer_with_rating(score, user)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end
    def create_beer_with_rating_and_style(score, style, user)
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end
  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end
  def create_beers_with_ratings_and_brewery(*scores, user, brewery)
    scores.each do |score|
        create_beer_with_rating(score, user, brewery:brewery)
    end
  end
end
