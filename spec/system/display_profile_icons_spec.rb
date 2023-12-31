require 'rails_helper'

RSpec.describe "DisplayProfileIcons", type: :system do
  before do
    driven_by(:selenium)
  end

  let!(:user) { User.create(first_name: 'abcde', last_name: 'wxzy', email: 'abcde@wxzy.com', password: 'foobar') }
  let!(:other_user) { User.create(first_name: 'george', last_name: 'washington', email: 'george@washington.com', password: 'foobar') }

  context 'a user is logged in at the users#index page' do
    before do
      login_as(other_user, scope: :user)
      visit new_user_profile_path(other_user)
      image_1_file_path = "#{Rails.root}/spec/files/image_1.jpg"
      attach_file(image_1_file_path)
      click_on "Submit Profile"
      click_on "Sign out"
    end

    it "shows them users names with profile pictures next to them" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on "Log in"
      expect(page).to have_content "Recent Posts"

      visit users_path
      click_on "Show Other Users"
      expect(page).to have_css("img[src*='image_1.jpg']")
    end
  end
end
