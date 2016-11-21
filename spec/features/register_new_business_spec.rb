require 'rails_helper'

feature "user registers a new business" do 
  scenario "user is not signed in" do 
    visit new_business_path
    expect(page).to have_content "You must be logged in to perform that action"
  end

  scenario "with invalid inputs" do 
    sign_in 
    visit new_business_path
    fill_in "Name", with: 'Target'
    fill_in 'Description', with: 'Sells everything'
    click_button 'Submit'

    expect(page).to have_content "can't be blank"
  end

  scenario "with valid inputs" do 
    sign_in
    visit new_business_path
    business_atts = Fabricate.attributes_for :business
    
    fill_in "Name", with: business_atts[:name] 
    fill_in "Description", with: business_atts[:description] 
    fill_in "City", with: business_atts[:city]
    click_button 'Submit' 
    expect(page).to have_content(business_atts[:name])
  end
end