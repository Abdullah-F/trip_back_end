class Trip < ApplicationRecord
  include AASM
  validates_presence_of :status
  after_commit :invalidate_cache

  has_many :drivers, dependent: :nullify
  has_many :locations, dependent: :destroy

  enum status: { ready: 0, ongoing: 1, completed: 2 }

  scope :search, -> do
    Rails.cache.fetch("trips") { all }
  end

  aasm(:status, column: :status, enum: true) do
    state :ready, initial: true
    state :ongoing, :completed

    event :go do
      transitions from: :ready, to: :ongoing
    end

    event :complete do
      transitions from: :ongoing, to: :completed
    end
  end

  def invalidate_cache
    Rails.cache.delete('trips')
  end
end
