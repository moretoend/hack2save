require 'test_helper'

class JobTest < ActiveSupport::TestCase
  should have_many :user_jobs
  should have_many :users
  should belong_to :institution

  should validate_presence_of :title

  def setup
    @job = jobs(:valid)
  end

  test 'valid job' do
    assert @job.valid?
  end
end
