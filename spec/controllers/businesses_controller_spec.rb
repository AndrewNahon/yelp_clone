require 'rails_helper'

describe BusinessesController do
  describe "GET index" do
    before { get :index }
    it "sets @businesses variable" do 
      business1 = Fabricate :business 
      business2 = Fabricate :business
      
      expect(assigns(:businesses)).to match_array [business1, business2]
    end
    
    it "renders the index template" do 
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    let(:business) { Fabricate(:business) }
    before { get :show, id: business.id }
    
    it "sets @business variable" do 
      expect(assigns(:business)).to eq(business)
    end

    it "sets @review variable" do 
      expect(assigns(:review)).to be_truthy
    end
    
    it "it renders the show template" do 
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    context "unathenticated user" do 
      it "redirects to sign in page unless user is signed in" do 
        get :new
        expect(response).to redirect_to sign_in_path
      end
      it "display a message" do 
        get :new
        expect(flash[:error]).to be_truthy
      end
    end 
    context "with authenticated user" do
      it "renders the new template" do
        set_current_user 
        get :new 
        expect(response).to render_template :new
      end
    end
  end

  describe "POST create" do 
    context "authenticated user" do
      before { set_current_user }
      
      context "with valid inputs" do
        before { post :create, business: Fabricate.attributes_for(:business) }
        it "registers a new business" do 
          expect(Business.count).to eq(1)
        end
        it "redirects to the business's show page" do 
          business = Business.first
          expect(response).to redirect_to business_path(business)
        end
        it "displays a message" do 
          expect(flash[:notice]).to be_truthy
        end
      end

      context "with invalid inputs" do
        before { post :create, business: {name: "Target"} }
        it "assigns @business" do 
          expect(assigns(:business)).to be_truthy
        end
        it "renders the new template" do 
          expect(response).to render_template :new
        end
      end 
    end

    context "unauthenticated user" do
      it "redirects to sign in page" do 
        post :create, Fabricate.attributes_for(:business)
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end