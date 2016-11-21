require 'rails_helper'

describe ReviewsController do 
  describe "Post create" do
    context "With authenticated user" do
      let (:andy) { Fabricate(:user) }
      let(:business1) { Fabricate(:business) }
      before { set_current_user(andy) }

      context "with valid inputs" do
        before { post :create, :business_id => business1.id, review: Fabricate.attributes_for(:review)}
        it "creates a new review" do 
          expect(Review.count).to eq(1)
        end
        it "associates the review with user" do 
          expect(Review.first.user).to eq(andy)
        end
        it "associates the review with the correct business" do 
          expect(Review.first.business).to eq(business1)
        end
        it "redirect to the business show page" do
          expect(response).to redirect_to business_path(business1)
        end
        it "display a message" do 
          expect(flash[:notice]).to be_truthy
        end
      end

      context "with invalid inputs" do
        before { post :create, business_id: business1.id, review: { body: "It's fantastic" } }
        it "sets @review" do 
          expect(assigns(:review)).to be_truthy
        end
        it "does not create a review" do 
          expect(Review.count).to eq(0)
        end
        it "redirects to the business show page" do 
          expect(response).to render_template :show
        end
      end
    end
  end
end