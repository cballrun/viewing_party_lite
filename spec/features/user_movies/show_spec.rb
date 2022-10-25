require 'rails_helper'

RSpec.describe 'the user movie show page', type: :feature do


  describe 'movie details section' do
    it 'shows the movies details' do
      VCR.use_cassette("user_movies_show", :allow_playback_repeats => true) do
        user = create(:user, id: 50, name: "Bubbles", email: "bubbles@sunnyvale.ca", password: "password")
        visit "/users/#{user.id}/movies/550"
        within("#movie_details") do
          expect(page).to have_content("Vote Average: 8.433")
          expect(page).to have_content("Runtime: 139")
          expect(page).to have_content("Summary:")
          expect(page).to have_content("Genres: Drama Thriller Comedy")
        end
      end
    end
  end

  describe 'the cast section' do
    it 'shows the first 10 cast members character and name' do
      VCR.use_cassette("user_movies_show_cast", :allow_playback_repeats => true) do
        user = create(:user, id: 50, name: "Bubbles", email: "bubbles@sunnyvale.ca", password: "password")
        visit "/users/#{user.id}/movies/550"
        within("#cast_info") do
          expect(page).to have_content(" as ", count: 10)
          expect(page).to have_content("Helena Bonham Carter", count: 1)
          expect(page).to have_content("Angel Face", count: 1)
        end
      end
    end
  end

  describe 'the reviews section' do
    it 'shows the first 10 cast members character and name' do
      VCR.use_cassette("user_movies_show_reviews", :allow_playback_repeats => true) do
        user = create(:user, id: 50, name: "Bubbles", email: "bubbles@sunnyvale.ca", password: "password")
        visit "/users/#{user.id}/movies/550"
        within("#reviews_info") do
          expect(page).to have_content("Author:", count: 7)
          expect(page).to have_content("Wuchak", count: 1)
          expect(page).to have_content("Madness unbounded. Don't try to make sense of insanity, just ride a wild ride.", count: 1)
        end
      end
    end
  end

  describe 'the buttons section' do
    it 'has a button to return to the discover page' do
      VCR.use_cassette("user_movies_show_buttons", :allow_playback_repeats => true) do
        user = create(:user, id: 50, name: "Bubbles", email: "bubbles@sunnyvale.ca", password: "password")
        visit "/users/#{user.id}/movies/550"
        within("#buttons") do
          expect(page).to have_selector("#discover_button")
          expect(page).to have_button("Discover")
          click_on("Discover")
          expect(current_path).to eq("/users/#{user.id}/discover")
        end
      end
    end

    it 'has a button to go to the create a new viewing party page' do
      VCR.use_cassette("user_movies_show_buttons", :allow_playback_repeats => true) do
        user = create(:user, id: 50, name: "Bubbles", email: "bubbles@sunnyvale.ca", password: "password")
        visit "/users/#{user.id}/movies/550"
        within("#buttons") do
          within("#new_party_button") do
            expect(page).to have_button("Create Viewing Party for Fight Club")
            # click_on("Create A New Viewing Party")
            # expect(current_path).to eq("/users/#{user.id}/movies/550/viewing-party/new")
          end
        end
      end
    end
  end


end