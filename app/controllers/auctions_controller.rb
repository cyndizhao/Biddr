class AuctionsController < ApplicationController
  before_action :get_auction, only:[:show]
  before_action :authenticate_user!, except: [:show, :index]


  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    # post_params = params.require(:post).permit([:title, :body, :category_id])
    @auction = Auction.new (auction_params)
    @auction.user = current_user
    if @auction.save
      flash[:notice] = "A New Auction Created Successfully!"
      redirect_to auction_path(@auction)
    else
      render :new
    end
  end

  def show
    @bid = Bid.new
    @current_price = @auction.current_price
    @reserve_price = @auction.reserve_price
  end

  private
  def get_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit([:title, :details, :ends_on, :reserve_price])
  end
end
