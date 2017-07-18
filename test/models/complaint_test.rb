require 'test_helper'

class ComplaintTest < ActiveSupport::TestCase
  should belong_to :denouncer
  should belong_to :denounced

  should validate_presence_of :reason
end
