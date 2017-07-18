class Institution < ApplicationRecord
  has_many :jobs
  has_many :permissions
  has_many :users, through: :permissions

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
end
