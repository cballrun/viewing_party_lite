require 'rails_helper'

RSpec.describe 'the User Registration Page' do

  before :each do
    visit "/register"
  end

  describe 'the user registration form' do
    it 'renders the form' do
      expect(page).to have_content('New User Registration')
      expect(find('form')).to have_content('Email')
      expect(find('form')).to have_button('Register')
    end
  end

  describe 'creating a new user' do
    context 'given valid data' do
      it 'can create a new user' do
        
        fill_in "Name", with: "Ricky"
        fill_in "Email", with: "ricky@sunnyvale.ca"
        fill_in "Password", with: "Password"
        fill_in "Password Confirmation", with: "Password"
        
        expect { click_on 'Register' }.to change { User.count }.by(1)
        user = User.last
        expect(user.name).to eq("Ricky")
        expect(user.email).to eq("ricky@sunnyvale.ca")
        # expect(current_path).to eq("/users/#{user.id}")
      end
    end

    context 'given invalid data' do
      it 'redirects to the registration page with error message on how to fix the error' do
        fill_in "Name", with: ''
        fill_in "Email", with: ''
        expect { click_on 'Register' }.to change { User.count }.by(0)
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Name can't be blank")
        expect(current_path).to eq("/register")
      end
    end

    context 'given a duplicate email' do
      it 'redirects to the registration page with error message on how to fix the error' do
        fill_in "Name", with: "Ricky"
        fill_in "Email", with: "ricky@sunnyvale.ca"
        fill_in "Password", with: "Password"
        fill_in "Password Confirmation", with: "Password"
        
        click_on "Register"

        visit "/register"

        fill_in "Name", with: "Ricky"
        fill_in "Email", with: "ricky@sunnyvale.ca"
        fill_in "Password", with: "Password"
        fill_in "Password Confirmation", with: "Password"

        expect { click_on 'Register' }.to change { User.count }.by(0)
        expect(page).to have_content("Email has already been taken")
        expect(current_path).to eq("/register")
      end
    end
  end

end