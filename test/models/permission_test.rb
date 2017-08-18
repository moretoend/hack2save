require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :institution

  should validate_presence_of :profile 
  should define_enum_for(:profile).with([:owner, :admin, :approver])
end
