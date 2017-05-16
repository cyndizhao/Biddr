class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction

  validates :user_id, uniqueness: {scope: :auction_id}
  validates :price, presence: true

end
