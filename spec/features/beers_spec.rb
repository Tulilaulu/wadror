require 'spec_helper'

describe "Beer adding page" do
  it "a beer can be added" do
        FactoryGirl.create(:brewery, name: "koff", year: 1234)
    visit new_beer_path
    expect(page).to have_content 'New beer'
    expect(page).to have_content 'Style'
    fill_in('beer_name', with:'mehu')
    expect{
	click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

    it "the page givers an error when trying to add beer without name" do
        FactoryGirl.create(:brewery, name: "koff", year: 1234)
      visit new_beer_path
     expect{
	click_button('Create Beer')
    }.to change{Beer.count}.by(0)      
     expect(page).to have_content 'Name can\'t be blank'

    end

end
