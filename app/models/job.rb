class Job < ApplicationRecord
  validates :title, presence: true

  belongs_to :institution
  has_many :user_jobs
  has_many :users, through: :user_jobs
end
