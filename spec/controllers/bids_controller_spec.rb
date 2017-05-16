require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:auction) {FactoryGirl.create(:auction)}
  let(:bid) {FactoryGirl.create(:bid, auction: auction, user:user)}
  describe '#create' do
    context 'with user sign in' do
      before { request.session[:user_id] = user.id }
      context 'with invalid attributes' do
        def invalid_request
          post :create, params: {auction_id: auction.id, bid: FactoryGirl.attributes_for(:bid, price: nil)}
        end

        it 'desnt\'t create  record in the database' do
          count_before = Bid.count
          invalid_request
          count_after = Bid.count
          expect(count_before).to eq(count_after)
        end

        it 'renders the new template' do
          invalid_request
          expect(response).to redirect_to(auction_path(auction.id))
        end
      end
    end
  end


  describe '#destroy' do
    context 'with signed in user' do
      before {request.session[:user_id] = user.id}
      context 'with signed in user is owner of compaign' do
        it 'removes the bid record form the database' do
          bid
          count_before = Bid.count
          delete :destroy, params: {auction_id: bid.auction.id, id: bid.id }
          count_after  = Bid.count
          expect(count_after).to eq(count_before - 1)
        end
        it 'render auction show page' do
          bid
          auction_id = bid.auction.id
          delete :destroy, params: {auction_id: bid.auction.id, id: bid.id }
          expect(response).to redirect_to(auction_path(auction_id))
        end
      end
    end
  end


end
