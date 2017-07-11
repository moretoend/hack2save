class Complaint < ApplicationRecord
  belongs_to :denunciable, class_name: 'User'
end
