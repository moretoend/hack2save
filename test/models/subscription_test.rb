require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :job

  should validate_presence_of :cover_letter

  should define_enum_for(:status).with([:pending, :rejected, :approved])

  test 'should set the default status' do
    subscription = Subscription.new({
      user_id: users(:standard).id, 
      job_id: jobs(:standard).id, 
      cover_letter: "Cover letter test",
    })
    subscription.valid?
    assert subscription.status == "pending"
  end

end
