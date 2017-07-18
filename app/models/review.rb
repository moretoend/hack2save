class Review < ApplicationRecord
  belongs_to :origin, polymorphic: true
  belongs_to :receiver, polymorphic: true

  validates :grade, presence: true, numericality: { only_integer: true }
end
