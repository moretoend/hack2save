class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :institution

  validates :profile, presence: true
end
