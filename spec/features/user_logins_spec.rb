require 'rails_helper'

RSpec.feature "Visitor logs in", type: :feature, js: true do

  # SETUP
  before :each do
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    @user = User.create!(
      email:  @email,
      email_confirmation:  @email,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      password: @password,
      password_confirmation: @password
    )

  end

  scenario "Visitor submits valid credentials" do
    # ACT
    visit '/login'
    fill_in 'email', with: @email
    fill_in 'password', with: @password
    click_on "Submit"

    # DEBUG

    # VERIFY
    expect(page).to have_text "Log out"
    save_screenshot
    puts page.html
  end

end
