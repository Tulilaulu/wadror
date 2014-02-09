require 'spec_helper'

BeerClub
BeerClubsController
Brewery
BreweriesController
Membership
MembershipsController
Rating
RatingsController


describe Beer do
  it "is saved when it has a name and a style" do
    beer = Beer.create name:"Kalja", style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
    beer.style.should == "Lager"
    beer.name.should == "Kalja"
  end

  it "is not saved without a name" do
    beer = Beer.create name:""

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
  it "is not saved without a style" do
    beer = Beer.create name:"Kalja", style:""

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
