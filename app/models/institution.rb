class Institution < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :users, through: :permissions
  has_many :subscriptions, through: :jobs

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
end
