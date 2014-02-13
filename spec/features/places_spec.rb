require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if multiple results are returned, they are all shown" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi"),  Place.new(:name => "Derp") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Derp"
  end
  it "if there are no results, display error" do
    BeermappingApi.stub(:places_in).with("asdf").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'asdf')
    click_button "Search"

    expect(page).to have_content "No locations in asdf"
  end

end
