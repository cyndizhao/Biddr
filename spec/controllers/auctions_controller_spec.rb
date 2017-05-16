require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:auction) {FactoryGirl.create(:auction)}
  let(:auction_1) {FactoryGirl.create(:auction)}

  describe '#new action' do
    context 'with no user sign in' do
      it 'redirect_to new_session template' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user sign in' do
      before { request.session[:user_id] = user.id }
      it 'assigns a instance variable ' do
        get :new
        expect(assigns(:auction)).to be_a_new(Auction)
      end
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create action' do
    before { request.session[:user_id] = user.id }
    context 'with valid attributes' do
      def valid_request
        post :create, params: {auction: FactoryGirl.attributes_for(:auction)}
      end
      it 'create a new instance for Auction in the database' do
        count_before = Auction.count
        valid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'set a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end

      it 'redirect to the auction show page' do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end
    end

    context 'with invalid attributes' do
      def invalid_request
        post :create, params: {auction: FactoryGirl.attributes_for(:auction, title:nil)}
      end
      it 'does not create a new Auction in the database' do
        count_before = Auction.count
        invalid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before)
      end

      it 'renders a new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end


  describe '#Index action' do
    it 'assigns a variable for all auctions' do
      auction
      auction_1
      get :index
      expect(assigns(:auctions)).to eq(Auction.last(20))
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#show action' do
    it 'assigns a varible for the auction with the passed in id' do
      get :show, params:{id:auction.id}
      expect(assigns(:auction)).to eq(auction)
    end

    it'renders the show template' do
      get :show, params:{id:auction.id}
      expect(response).to render_template(:show)
    end
  end
end
