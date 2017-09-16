require 'test_helper'

class InstitutionsSubscriptionsControllerTest < ActionController::TestCase

    include Devise::Test::ControllerHelpers


    setup do
        @user = users(:standard)
        sign_in @user
        @institution = institutions(:standard)
        @institution.permissions.create(user: @user, profile: :owner)
        @subscription = subscriptions(:standard)

        @subscription2 = Subscription.create(
            cover_letter: "Cover Letter",
            job: jobs(:job_2),
            user: @user
        )
        @subscription.update_attributes(created_at: Date.today - 15.days)
    end

    test "GET #index should renders :index template" do
        get :index, params: { institution_id: @institution.id }
        assert_template :index
    end

    test "GET #index should return :success response" do
        get :index, params: { institution_id: @institution.id }
        assert_response :success
    end

    test "GET #index should return list of subscriptions" do
        get :index, params: { institution_id: @institution.id }
        assert assigns(:subscriptions) == [@subscription, @subscription2]
    end
    
    test "GET #index should return list of subscriptions with date greater than 10 days before" do
        date = Date.today - 10.days
        get :index, params: { 
            institution_id: @institution.id,  
            date_start: date.strftime('%d/%m/%Y'),
            date_end: "",
            search: ""
        }
        assert assigns(:subscriptions) == [@subscription2]
    end

    test "GET #index should return list of subscriptions with date lesser than 10 days before" do
        date = Date.today - 10.days
        get :index, params: { 
            institution_id: @institution.id,  
            date_start: "",
            date_end: date.strftime('%d/%m/%Y'),
            search: ""
        }
        assert assigns(:subscriptions) == [@subscription]
    end

    test "GET #index should return list of subscriptions with the search 'job 2'" do
        get :index, params: { 
            institution_id: @institution.id,  
            date_start: "",
            date_end: "",
            search: "Title 1"
        }
        assert assigns(:subscriptions) == [@subscription]
    end

    test "GET #index should return 302 response without permission" do
        sign_in(users(:user_9))
        get :index, params: { institution_id: @institution.id }
        assert_response 302
    end

end

