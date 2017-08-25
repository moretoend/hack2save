require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :institution

  should validate_presence_of :profile 
  should define_enum_for(:profile).with([:owner, :admin, :approver])

  setup do
    @user = users(:user_3)
    @institution = institutions(:standard)
    @institution.permissions.create(user: @user, profile: :owner)
  end

  test 'can_approve? should return true when user is owner' do
    assert Permission.can_approve?(@institution, @user) == true
  end

  test 'can_approve? should return false when user has no permission' do
    assert Permission.can_approve?(@institution, users(:user_4)) == false
  end
end
