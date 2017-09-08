require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
    setup do
        @user = users(:standard)
        @ability = Ability.new(@user)
        @institution = institutions(:standard)
    end
    
    test "users without profile can only create a subscription" do
        assert @ability.can?(:create, Subscription)
        assert @ability.cannot?(:update, Subscription.new)
        assert @ability.cannot?(:read, Subscription.new)
    end

    test "user can only read a subscription which they own" do
        assert @ability.can?(:read, Subscription.new(user: @user))
        assert @ability.cannot?(:update, Subscription.new(user: @user))
    end

    test "user can update a subscription which they have profile 'owner' in the institution" do
        @institution.permissions.create(user: @user, profile: :owner)
        assert @ability.can?(:update, Subscription.new(user: @user, institution: @institution))
    end

    test "user can update a subscription which they have profile 'admin' in the institution" do
        @institution.permissions.create(user: @user, profile: :admin)
        assert @ability.can?(:update, Subscription.new(user: @user, institution: @institution))
    end

    test "user can update a subscription which they have profile 'approver' in the institution" do
        @institution.permissions.create(user: @user, profile: :approver)
        assert @ability.can?(:update, Subscription.new(user: @user, institution: @institution))
    end

    test "users can destroy a subscription" do
        assert @ability.cannot?(:destroy, Subscription.new)
    end
end
