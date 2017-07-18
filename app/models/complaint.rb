class Complaint < ApplicationRecord
  belongs_to :denouncer, polymorphic: true
  belongs_to :denounced, polymorphic: true 
  
  validates :reason, presence: true
end
