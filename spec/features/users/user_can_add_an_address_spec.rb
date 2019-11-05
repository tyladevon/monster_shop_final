require 'rails_helper'

RSpec.describe "As a registered User" do
  context "when I visit my show page"
  before(:each) do
    @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
    @address = @user.addresses.create(nickname: 'home', name: 'Megan', address: '9876 Pearl', city: 'Boulder', state:'CO', zip: 80302)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit profile_path
  end

  it "I can add an address to my profile" do
    expect(page).to have_css(".addresses")
    within ".addresses"
      click_on "Add New Address"
      expect(current_path).to eq("/users/#{@user.id}/addresses/new")

    fill_in 'Nickname', with: 'Mom'
    fill_in 'Name', with: 'Tyla'
    fill_in 'Address', with: '587 Hill St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80201'

    click_on "Submit"

    expect(current_path).to eq('/profile')

    within ".addresses"
      expect(page).to have_content("Mom")
      expect(page).to have_content("Tyla")
      expect(page).to have_content("587 Hill St")
  end

  it "I can change an address in my profile" do
    within ".addresses"
    click_on "Edit Address"
    expect(current_path).to eq(edit_user_address_path(@user.id, @address.id))

    fill_in 'Nickname', with: 'Home'
    fill_in 'Name', with: 'Megan'
    fill_in 'Address', with: '93456 Broadway'
    fill_in 'City', with: 'Boulder'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80302'

    click_on "Submit"

    expect(current_path).to eq('/profile')
    within ".addresses"
      # expect(page).to have_content('Home')
      # expect(page).to_not have_content('9876 Pearl')

  end

  it "I can delete an address in my profile" do

  end

  it "I cannot delete an address if address has been used in a shipped order" do

  end
end

# Users need full CRUD ability for addresses from their Profile page.
