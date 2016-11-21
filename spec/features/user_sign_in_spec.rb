require 'rails_helper'

feature "user signs in" do 
  let(:andy) { Fabricate(:user) }
  
  scenario "with valid email and password" do 
    sign_in andy
    expect(page).to have_content "Hello! #{andy.username}"
  end

  scenario "with invalid inputs" do 
    visit sign_in_path
    fill_in 'Email', with: andy.email
    fill_in "Password", with: (andy.password + '123')
    click_button 'Submit'

    expect(page).to have_selector("#flash_error") 
  end
end