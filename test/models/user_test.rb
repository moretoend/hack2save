require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many :user_jobs
  should have_many :jobs
  should have_many :reviews
  should have_many :institutions
  should have_many :institution_users
  should have_many :complaints

  def setup
    @user = users(:valid)
  end

  test 'valid user' do
    assert @user.valid?
  end
end
