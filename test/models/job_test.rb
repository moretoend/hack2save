require 'test_helper'

class JobTest < ActiveSupport::TestCase
  should belong_to :institution
  should have_many :subscriptions
  should have_many(:users).through(:subscriptions)

  should validate_presence_of :title
  should validate_presence_of :description
  should validate_presence_of :requirements
  should validate_presence_of :start_date
  should validate_presence_of :end_date
end
