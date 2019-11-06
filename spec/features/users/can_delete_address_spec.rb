require 'rails_helper'

describe "As a registered User" do
  context "when I visit my show page"
    before(:each) do
      @user = User.create!(name: 'Tyla', email: 'tyla@example.com', password: 'securepassword')
      @address = @user.addresses.create(nickname: 'Mountains', name: 'Tyla', address: '9876 Pearl', city: 'Boulder', state:'CO', zip: 80302)
      @order = Order.create!(user_id: @user.id, status: 2, address_id: @address.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path
    end

  it "I can delete an address in my profile" do

    within ".addresses-#{@address.id}" do
      click_on "Delete"
    end
    # expect(current_path).to eq('/profile')
    # expect(page).to_not have_content("Nickname: Mountains")
    # expect(page).to_not have_content("Name: Tyla")
  end

  it "I cannot delete an address if address has been used in a shipped order" do
    click_on "Delete"
    save_and_open_page
    expect(current_path).to eq("/profile")
    expect(page).to have_content("Can't delete address")
  end
end
