class Institution < ApplicationRecord
  has_many :jobs
  has_many :institution_users
  has_many :users, through: :institution_users
  validates :name, presence: true
end
