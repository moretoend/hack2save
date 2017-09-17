require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  fixtures :all
  include I18nSupport
end


class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
