require 'test_helper'

class InstitutionUserTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :institution
end
