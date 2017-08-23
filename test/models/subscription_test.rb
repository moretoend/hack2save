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

  test 'should not update cover letter' do
    subscription = subscriptions(:standard)
    subscription.update_attributes({ cover_letter: "test 2"})
    subscription.reload
    assert subscription.cover_letter != "test 2"
  end

  test 'should not update job' do
    subscription = subscriptions(:standard)
    job = jobs(:job_1)
    subscription.update_attributes({ job: job})
    subscription.reload
    assert subscription.job_id != job.id
  end

  test 'should not update user' do
    subscription = subscriptions(:standard)
    user = users(:user_1)
    subscription.update_attributes({ user: user})
    subscription.reload
    assert subscription.user_id != user.id
  end

end
