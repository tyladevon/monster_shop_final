require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Create Order' do
  describe 'As a Registered User' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @address = @user.addresses.create!(nickname: 'Home', name: 'Megan', address: '9876 Pearl', city: 'Boulder', state:'CO', zip: 80302)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click a link next to an address to create an order' do
      visit item_path(@ogre)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'

      visit '/cart'

      click_on "Checkout with this address"

      expect(current_path).to eq('/profile/orders')

      order = Order.last
      within "#orders-#{order.id}" do
        expect(page).to have_content(order.address.nickname)
        expect(page).to have_content(order.address.address)
        expect(page).to have_link(order.id)
      end

      expect(page).to have_content('Order created successfully!')
      expect(page).to have_link('Cart: 0')

      end
    end
  end

  # describe 'As a Visitor' do
  #   before :each do
  #     @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
  #     @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
  #     @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
  #     @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
  #     @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
  #   end

  #   it "I see a link to log in or register when trying to checkout" do
  #     visit item_path(@ogre)
  #     click_button 'Add to Cart'
  #     visit item_path(@hippo)
  #     click_button 'Add to Cart'
  #     visit item_path(@hippo)
  #     click_button 'Add to Cart'
  #
  #     visit '/cart'
  #
  #     expect(page).to_not have_button('Check Out')
  #
  #     within '#checkout' do
  #       click_link 'register'
  #     end
  #
  #     expect(current_path).to eq(registration_path)
  #
  #     visit '/cart'
  #
  #     within '#checkout' do
  #       click_link 'log in'
  #     end
  #
  #     expect(current_path).to eq(login_path)
  #   end
  # end
