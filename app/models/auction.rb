class Auction < ApplicationRecord
  belongs_to :user
  has_many :tracks, dependent: :destroy
  has_many :bids, dependent: :destroy
  validates :title, presence: true
  validates :details, presence: true
  validates :ends_on, presence: true
  validates :reserve_price, presence: true
  validates :current_price, presence:true

  include AASM
    aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :reserve_not_met
    state :won
    state :cancelled


    event :publish do
      transitions from: :draft, to: :published
    end

    event :reserve_meet do
      transitions from: :published, to: :reserve_met
    end

    event :reserve_not_meet do
      transitions from: :published, to: :reserve_not_met
    end

    event :win do
      transitions from: :reserve_met, to: :won
    end

    event :cancel do
      transitions from: [:published, :reserve_met, :reserve_not_met, :won], to: :cancelled
    end

    event :relaunch do
      transitions from: :cancelled, to: :draft
    end

  end

  def track_by?(user)
    tracks.exists?(user: user)
  end

  def track_for(user)
    tracks.find_by(user: user)
  end
end
