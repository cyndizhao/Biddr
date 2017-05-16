class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # can [:create], Bid do |bid|
    #   bid.user == user
    # end
    can :bit, Auction do |a|
      user != a.user
    end
    cannot :bit, Auction do |a|
      user == a.user
    end

    can [:destroy], Bid do |b|
      b.user == user
    end

    can :track, Auction do |auction|
      user != auction.user
    end
    cannot :track, Auction do |auction|
      user == auction.user
    end

  end
end
