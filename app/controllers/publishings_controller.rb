class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    auction = Auction.find params[:auction_id]
    if auction.user == current_user
      if auction.publish!
        redirect_to auction, notice: 'Auction is published!'
      else
        redirect_to auction, alert: 'Can\'t publish auction, already published?'
      end
    else
      redirect_to auction, alert: 'Can\'t publish other\'s auction!'
    end
  end
end
