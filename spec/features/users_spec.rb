require 'spec_helper'
include OwnTestHelper

describe "User" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user1) { FactoryGirl.create :user, username:"Pekka" }
  let!(:user2) { FactoryGirl.create :user, username:"Matti" }


  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "users page shows users ratings but no other ratings" do
      FactoryGirl.create(:rating, score:10, beer:beer, user:user1)
      FactoryGirl.create(:rating, score:15, beer:beer, user:user1)
      FactoryGirl.create(:rating, score:20, beer:beer, user:user2)
      FactoryGirl.create(:rating, score:30, beer:beer, user:user1)
    visit user_path(user1)
    expect(page).to have_content 'Karhu 10'
    expect(page).to have_content 'Karhu 15'
    expect(page).to have_content 'Karhu 30'
    page.should have_no_content('Karhu 20')
  end
end
