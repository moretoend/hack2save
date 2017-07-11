require 'test_helper'

class UserJobTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :job

  def setup
    @user_job = user_jobs(:valid)
  end

  test 'valid user_job' do
    assert @user_job.valid?
  end

  test 'invalid without user' do
    @user_job.user = nil
    assert @user_job.invalid?
  end

  test 'invalid without job' do
    @user_job.job = nil
    assert @user_job.invalid?
  end
end
