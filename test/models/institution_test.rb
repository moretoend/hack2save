require 'test_helper'

class InstitutionTest < ActiveSupport::TestCase
  should have_many :jobs
  should have_many :permissions
  should have_many(:users).through(:permissions)
  
  should validate_presence_of :name
  should validate_presence_of :description
  should validate_presence_of :category
end
