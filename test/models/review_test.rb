require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  should belong_to :reviewable

  def setup
    @review = reviews(:valid)
  end

  test 'valid review' do
    assert @review.valid?
  end
end
