class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :status, presence: true
  validates :cover_letter, presence: true

  enum status: { pending: 0, rejected: 1, approved: 2 }
end
