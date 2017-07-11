require 'test_helper'

class InstitutionTest < ActiveSupport::TestCase
  should have_many :jobs
  should have_many :institution_users
  should have_many :users

  should validate_presence_of :name

  def setup
    @institution = institutions(:valid)
  end

  test 'valid institution' do
    assert @institution.valid?
  end
end
