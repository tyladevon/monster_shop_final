require 'rails_helper'

describe "As a new user" do
  describe "after I complete my registration page" do
    before(:each) do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/users/#{@user.id}/addresses/new"
    end

    it "I am redirected to an 'add address' page, fill in address information and am redirected to profile path" do

      expect(page).to have_content("Hello #{@user.name}, please provide a primary address!")

      fill_in 'Nickname', with: 'Home'
      fill_in 'Name', with: 'Megan'
      fill_in 'Address', with: '9876 Pearl St'
      fill_in 'City', with: 'Boulder'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80302'

      click_on "Submit"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome #{@user.name}!")
    end

      it 'I must complete all fields of address form' do

        fill_in 'Nickname', with: 'Home'
        fill_in 'Name', with: 'Megan'
        fill_in 'Address', with: '9876 Pearl St'
        fill_in 'City', with: 'Boulder'
        fill_in 'State', with: 'CO'

        click_on "Submit"

        expect(current_path).to eq("/users/#{@user.id}/addresses/new")
        expect(page).to have_content("Please fill in all fields to finish registration")

      end
  end
end
