require 'test_helper'

class ComplaintTest < ActiveSupport::TestCase
  should belong_to :denunciable

  def setup
    @complaint = complaints(:valid)
  end

  test 'valid complaint' do
    assert @complaint.valid?
  end
end
