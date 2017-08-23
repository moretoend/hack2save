class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :institution

  validates :profile, presence: true

  enum profile: { owner: 0, admin: 1, approver: 2 }
end
