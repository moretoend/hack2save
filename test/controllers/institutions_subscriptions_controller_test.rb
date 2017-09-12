require 'test_helper'

class InstitutionsSubscriptionsControllerTest < ActionController::TestCase

    include Devise::Test::ControllerHelpers


    setup do
        @user = users(:standard)
        sign_in @user
        @institution = institutions(:standard)
        @institution.permissions.create(user: @user, profile: :owner)
        @subscription = subscriptions(:standard)
    end

    test "GET #index should renders :index template" do
        get :index, params: { institution_id: @institution.id }
        assert_template :index
    end

    test "GET #index should return :success response" do
        get :index, params: { institution_id: @institution.id }
        assert_response :success
    end

    test "GET #index should return list of subscriptions of a job" do
        get :index, params: { institution_id: @institution.id }
        assert assigns(:subscriptions) == [@subscription]
    end

    test "GET #index should return 302 response without permission" do
        sign_in(users(:user_9))
        get :index, params: { institution_id: @institution.id }
        assert_response 302
    end

end

