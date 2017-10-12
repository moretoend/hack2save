class Job < ApplicationRecord
  belongs_to :institution
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  
  validates :title, presence: true
  validates :description, presence: true
  validates :requirements, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :most_recent, -> { order(created_at: :desc).limit(5) }
end
