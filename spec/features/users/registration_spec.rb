require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'As a Visitor' do
    it 'I see a link to register as a user' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq(registration_path)
    end

    it 'I can register as a user' do
      visit registration_path

      fill_in 'Name', with: 'Megan'
      fill_in 'Email', with: 'megan@example.com'
      fill_in 'Password', with: 'securepassword'
      fill_in 'Password confirmation', with: 'securepassword'
      click_on 'Submit'

      user = User.last

      expect(current_path).to eq("/users/#{user.id}/addresses/new")
    end

    describe 'I can not register as a user if' do
      it 'I do not complete the registration form' do
        visit registration_path

        fill_in 'Name', with: 'Megan'
        click_on 'Submit'
        expect(current_path).to eq(users_path)
        expect(page).to have_content("email: [\"can't be blank\"]")
        expect(page).to have_content("password: [\"can't be blank\"]")
      end

      it 'I use a non-unique email' do
        user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')

        visit registration_path

        fill_in 'Name', with: user.name
        fill_in 'Email', with: 'megan@example.com'
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
        click_on 'Submit'

        expect(page).to have_content("email: [\"has already been taken\"]")
      end
    end
  end
end
