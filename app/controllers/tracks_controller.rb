class TracksController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @auctions = user.track_auctions
  end

  def create
    auction = Auction.find(params[:auction_id])
    track = Track.new(user: current_user, auction: auction)
    if cannot? :track, auction
      redirect_to auction_path(auction), alert: 'Can not track your own auction'
      return
    end
    if track.save
      redirect_to auction_path(auction), notice: 'auction tracked!'

    else
      redirect_to auction_path(auction), alert: track.errors.full_messages(',')
    end
  end

  def destroy
    track = Track.find(params[:id])
    if cannot? :track, track.auction
      redirect_to auction_path(track.auction), alert: 'Can not UnTrack your own auction'
      return
    end

    if track.destroy
      redirect_to auction_path(track.auction), notice:'Un-tracked auction!'
    else
      redirect_to auction_path(track.auction), alert: track.errors.full_messages.join(', ')
    end
  end
end
