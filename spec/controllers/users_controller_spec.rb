require 'rails_helper'

describe UsersController do
  before { get :new}
  describe "GET new" do 
    
    it "sets @user" do 
      expect(assigns(:user)).to be_truthy
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST create" do 
    context "with valid inputs" do 
      it "creates a new user" do 
        post :create, user: Fabricate.attributes_for(:user) 
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do 
        post :create, user: Fabricate.attributes_for(:user) 
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid inputs" do
      it "does not create new user" do 
        post :create, user: { username: 'Andrew' }
        expect(User.count).to eq(0)
      end
      it "renders the new user template" do 
        post :create, user: { username: 'Andrew' }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    let(:andy) { Fabricate(:user) }
    before { get :show, id: andy.id } 
    it "sets @user" do 
      expect(assigns(:user)).to eq(andy)
    end
    it "renders show template" do
      expect(response).to render_template :show
    end
  end
end