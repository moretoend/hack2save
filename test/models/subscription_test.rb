require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :job

  should validate_presence_of :status
  should validate_presence_of :cover_letter
end
