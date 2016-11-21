require 'rails_helper'

feature "register new user" do 
  before { visit new_user_path }
  
  scenario "with valid inputs" do 
    fill_in_user_register_form
    fill_in 'Email', with: 'andrew@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Submit'
    expect(page).to have_content "Andrew"
  end

  scenario "with invalid inputs" do
    visit new_user_path
    fill_in "Username", with: "Andrew"
    fill_in "Email", with: 'andrew@gmail.com'
    fill_in "Write something about yourself.", with: "Nice to meet you."
    click_button 'Register'
    expect(page).to have_content "can't be blank"
  end
end

def fill_in_user_register_form 
  fill_in "Username", with: "Andrew"
  fill_in "Email", with: 'andrew@gmail.com'
  fill_in "Write something about yourself.", with: "Nice to meet you."
  fill_in "Password", with: 'password'
  click_button 'Register'
end