require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  should belong_to :origin
  should belong_to :receiver

  should validate_presence_of :grade
  should validate_numericality_of(:grade).only_integer
end
