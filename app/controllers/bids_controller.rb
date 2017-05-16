class BidsController < ApplicationController
  before_action :authenticate_user!

  def create
    @auction = Auction.find(params[:auction_id])
    bid_params = params.require(:bid).permit(:price)
    @bid = Bid.new(bid_params)
    @bid.auction = @auction
    @bid.user = current_user
    price = @bid.price
    if cannot? :bit, @auction
      redirect_to auction_path(@auction), alert: "Can not bit your own auction!"
    elsif @bid.price.present? && @bid.price <= @auction.current_price
      redirect_to auction_path(@auction), alert: "Bid must be higher than current price!"
    elsif @bid.save
      @auction.update(current_price: price)
      if (@auction.current_price >= @auction.reserve_price) && (@auction.aasm_state != 'reserve_met')
        @auction.update(aasm_state: 'reserve_met')
      end
      redirect_to auction_path(@auction), notice:'Bid Created'
    else
      redirect_to auction_path(@auction), alert: @bid.errors.full_messages.join(', ')
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    if !can? :destroy, @bid
      redirect_to auction_path(params[:auction_id]), alert:'Access denied!'
    else
      @bid.destroy
      redirect_to auction_path(params[:auction_id]), notice:'Bid Deleted!'
    end
  end
end
