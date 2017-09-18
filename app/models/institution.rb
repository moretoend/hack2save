class Institution < ApplicationRecord

  has_many :jobs, dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :users, through: :permissions
  has_many :subscriptions, through: :jobs

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true

  enum category: { agriculture: 0, construction: 1, transportation: 2, communications: 3, sanitary: 4,
                   services: 5, healthcare: 6 }

  include EnumAddons

end
