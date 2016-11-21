require "rails_helper"

describe Review do 
 it { should belong_to :business }
 it { should belong_to :user }
 it { should validate_presence_of :rating }
 it { should validate_presence_of :body }
 it { should validate_uniqueness_of(:user_id).scoped_to :business_id }

 describe "#self.recent_reviews" do
  it "returns 10 reviews" do 
    10.times { Fabricate(:review) }
    expect(Review.recent_reviews.count).to eq(10)
  end

  it "returns all reviews if there are less than 10 total reviews" do 
    5.times { Fabricate(:review) }
    expect(Review.recent_reviews.count).to eq(5)
  end

  it "returns the most recent 10 reviews" do 
    10.times { Fabricate(:review, created_at: 1.days.ago) }
    review = Fabricate(:review)
    expect(Review.recent_reviews.first).to eq(review)
  end
 end
end