require 'rails_helper'

describe SessionsController do 
  describe "GET new" do
    it "redirects to the businesses page if the user is already logged in" do
      set_current_user 
      get :new 
      expect(response).to redirect_to root_path
    end
    it 'renders the new template' do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let(:andy) { Fabricate(:user) }
    before { post :create, email: andy.email, password: andy.password } 
    
    context "valid email and password" do
      it "signs in the user" do 
        expect(session[:user_id]).to eq(andy.id)
      end
      it "redirects to the root path" do 
        expect(response).to redirect_to root_path
      end
      it "display a message" do 
        expect(flash[:notice]).to be_truthy
      end
    end

    context "invalid inputs" do
      before { post :create, email: andy.email, password: andy.password + '123' }
      
      it 'redirects to the sign in page' do 
        expect(response).to redirect_to sign_in_path
      end
      it 'displays an error message' do
        expect(flash[:error]).to be_truthy
      end
    end
  end

  describe "GET destroy" do
    before do 
      set_current_user
      get :destroy
    end 
    it "logs out the user" do 
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do 
      expect(response).to redirect_to root_path
    end
    it "display a message" do
      expect(flash[:notice]).to be_truthy
    end
  end
end