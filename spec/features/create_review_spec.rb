require 'rails_helper'

feature 'create a new review' do
  let(:andy) { Fabricate(:user) }
  let(:business) { Fabricate(:business) }
  before do 
    sign_in(andy)
    visit business_path(business)
  end 
  
  scenario 'with valid inputs' do 
    fill_in_review_form
    expect(page).to have_content(andy.username + ' wrote a review')
  end

  scenario 'with invalid inputs' do
    click_button('Submit')
    expect(page).to  have_content("can't be blank")
  end

end

def fill_in_review_form 
  select([1,2,3,4].sample)
  fill_in 'Write your review', with: Faker::Lorem.sentence
  click_button 'Submit'
end