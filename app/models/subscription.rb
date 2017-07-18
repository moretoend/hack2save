class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :status, presence: true
  validates :cover_letter, presence: true
end
