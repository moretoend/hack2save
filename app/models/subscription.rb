class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :status, presence: true
  validates :cover_letter, presence: true

  enum status: { pending: 0, rejected: 1, approved: 2 }

  before_validation :set_default_status, on: :create

  private
  
  def set_default_status
    self.status = :pending
  end
end
