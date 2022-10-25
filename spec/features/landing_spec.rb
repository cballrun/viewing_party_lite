require 'rails_helper'

RSpec.describe 'When I visit the landing page', type: :feature do
  let!(:erin) { User.create!(name: 'Erin', email: 'epintozzi@turing.edu', password: "password") }
  let!(:mike) { User.create!(name: 'Mike', email: 'mike@turing.edu', password: "password") }
  let!(:meg) { User.create!(name: 'Meg', email: 'mstang@turing.edu', password: "password") }
  before(:each) {visit '/'}

  describe ' the header content' do
    it 'has a link "Home" to landing page' do
      within '#nav' do
        expect(page).to have_link('Home', href: '/')
      end
    end
  end

  describe 'the page content' do

    it 'has a button to create new user' do
      expect(page).to have_button('Create a New User')
      click_button
      expect(current_path).to eq('/register')
    end

    describe 'has an existing users list' do
      it 'shown on page' do
        expect(page).to have_selector('#user-list', count: 1)
      end

      it 'that shows emails of existing users' do
        within '#user-list' do
          expect(page).to have_selector('.user-dash-link', count: 3)

          expect(page).to have_content("#{erin.email}'s Dashboard")
          expect(page).to have_content("#{mike.email}'s Dashboard")
          expect(page).to have_content("#{meg.email}'s Dashboard")
        end
      end

      it 'that updates when new user created' do
        within '#user-list' do
          expect(page).to have_selector('.user-dash-link', count: 3)

          expect(page).to_not have_content("generic_email@gmail.com's Dashboard")
        end

        User.create!(name: 'Nobody', email: 'generic_email@gmail.com', password: "password")
        refresh

        within '#user-list' do
          expect(page).to have_selector('.user-dash-link', count: 4)
          expect(page).to have_content("generic_email@gmail.com's Dashboard")
        end
      end

      it 'where each listed user links to their dashboard' do
        within '#user-list' do
          expect(page).to have_link("#{erin.email}'s Dashboard", href: "/users/#{erin.id}")
          expect(page).to have_link("#{mike.email}'s Dashboard", href: "/users/#{mike.id}")
          expect(page).to have_link("#{meg.email}'s Dashboard", href: "/users/#{meg.id}")
          click_link "#{erin.email}'s Dashboard"
        end
        expect(current_path).to eq(user_path(erin))
      end
    end
  end
end
