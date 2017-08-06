require 'test_helper'

class CallbacksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
		OmniAuth.config.test_mode = true
		OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        'provider' => 'facebook',
        'uid' => '12457896583',
        'info' => {'email' => 'login.with.facebook@mail.com', 'name' => 'Login With Facebook', 'image' => ''}
    })
  end

  test 'Login with facebook' do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    request.env["devise.mapping"] = Devise.mappings[:user]
    assert_difference 'User.count', 1 do
			get :facebook
		end
    # get :facebook
    # assert_difference User.last.email, 'john.doe@mail.com'
  end

end
