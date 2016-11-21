require "rails_helper"

describe Business do 
 it { should have_many :reviews }
 it { should validate_presence_of(:name) }
 it { should validate_presence_of(:description) }
 it { should validate_presence_of(:city) }
 it { should validate_uniqueness_of(:name) }

 describe "#rating" do 
  it "returns business's average rating" do 
    business = Fabricate(:business)
    Fabricate(:review, rating: 5, business: business)
    Fabricate(:review, rating: 3, business: business)
    expect(business.rating).to eq(4)
  end
  
  it "returns nil if the restaurant has no reviews" do 
    business = Fabricate(:business) 
    expect(business.rating).to be_nil
  end

  it "returns a number rounded to the first decimal" do
    business = Fabricate(:business)  
    Fabricate(:review, rating: 5, business: business)
    Fabricate(:review, rating: 3, business: business)
    Fabricate(:review, rating: 3, business: business)
    expect(business.rating).to eq(3.7)
  end
 end

 describe "#has_review_by?" do
    it "returns false if the business has a review by user" do 
      andy = Fabricate(:user)
      business = Fabricate(:business)
      review = Fabricate(:review, business: business, user: andy)
      expect(business.has_no_review_by?(andy)).to eq(false)
    end
    
    it "returns false if the business does not have a review by user" do 
      andy = Fabricate(:user)
      business = Fabricate(:business)
      expect(business.has_no_review_by?(andy)).to eq(true)
    end
 end

 describe "#has_been_reviewed?" do 
  it "returns true if the business has at least one review" do 
    business = Fabricate(:business)
    Fabricate(:review, business: business)
    expect(business.has_been_reviewed?).to be(true)
  end

  it "returns false if the business has no reviews" do 
    business = Fabricate(:business)
    expect(business.has_been_reviewed?).to be(false)
  end
 end
end