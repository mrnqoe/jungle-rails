require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    # 3.times do |n|
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset("apparel1.jpg"),
      quantity: 10,
      price: 64.99
    )
    # end
  end

  scenario "They see details of one product" do
    # ACT
    visit root_path
    find_link("Details").trigger('click')

    # DEBUG

    # VERIFY
    expect(page).to have_css 'section.products-show'
    # save_screenshot
    # puts page.html
  end

end
