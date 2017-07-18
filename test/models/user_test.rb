require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many :subscriptions
  should have_many(:jobs).through(:subscriptions)
  should have_many :reviews
  should have_many :permissions
  should have_many(:institutions).through(:permissions)
  should have_many :complaints
end
