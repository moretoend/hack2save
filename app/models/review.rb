class Review < ApplicationRecord
  belongs_to :reviewable, class_name: 'User'
end
