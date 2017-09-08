require 'test_helper'


class SubscriptionsControllerTest < ActionController::TestCase

    include Devise::Test::ControllerHelpers

    setup do
        @user = users(:user_3)
        @institution = institutions(:standard)
        @institution.permissions.create(user: @user, profile: :owner)
        @job = jobs(:standard)
        @subscription = subscriptions(:standard)
        sign_in(@user)
    end

    test "GET #index should renders :index template" do
        get :index, params: { job_id: @job.id }
        assert_template :index
    end

    test "GET #index should return :success response" do
        get :index, params: { job_id: @job.id }
        assert_response :success
    end

    test "GET #index should return list of subscriptions of a job" do
        get :index, params: { job_id: @job.id }
        assert assigns(:subscriptions) == [@subscription]
    end

    test "GET #new should renders :new template" do
        get :new, params: { job_id: @job.id  }
        assert_template :new
    end

    test "GET #new should return :success response" do
        get :new, params: { job_id: @job.id }
        assert_response :success
    end

    test "GET #new should return a new subscription associated with job" do
        get :new, params: { job_id: @job.id }
        assert assigns(:subscription).job == @job
    end

    test "POST #create should add a new subscription with valid attributes" do
        params = { 
            user_id: users(:standard).id,
            job_id: jobs(:standard).id,
            cover_letter: "Cover letter test"
        }
        assert_difference("Subscription.count", 1) do
            post :create, params: { job_id: @job.id, subscription: params }
        end
    end
   
    test "POST #create should redirect_to :show with valid attributes" do
        params = { 
            user_id: users(:standard).id, 
            job_id: jobs(:standard).id,
            cover_letter: "Cover letter test"
        }
        post :create, params: { job_id: @job.id, subscription: params }
        assert_redirected_to subscription_path(assigns(:subscription).id)
    end

    test "POST #create should not add a subscription with invalid attributes" do
        params = { 
            user_id: users(:standard).id
        }
        assert_no_difference("Subscription.count") do
            post :create, params: { job_id: @job.id, subscription: params }
        end
    end

    test "POST #create should render :new with invalid attributes" do
        params = { 
            user_id: users(:standard).id
        }
        post :create, params: { job_id: @job.id, subscription: params }
        assert_template :new
    end

    test "POST #create should return 422 response with invalid attributes" do
        params = { 
            user_id: users(:standard).id 
        }
        post :create, params: { job_id: @job.id, subscription: params }
        assert_response 422
    end

    test "GET #show should renders :show template" do
        get :show, params: { id: @subscription.id }
        assert_template :show
    end

    test "GET #show should return :success response" do
        get :show, params: { id: @subscription.id }
        assert_response :success
    end

    test "GET #edit should renders :edit template" do
        get :edit, params: { id: @subscription.id }
        assert_template :edit
    end

    test "GET #edit should return :success response" do
        get :edit, params: { id: @subscription.id }
        assert_response :success
    end

    test "GET #edit should assign :permission" do
        get :edit, params: { id: @subscription.id }
        assert assigns(:subscription) == @subscription
    end

    test "PATCH #update should update a subscription with valid attributes" do
        params = { 
            status: :approved
        }
        patch :update, params: {id: @subscription.id, subscription: params }
        @subscription.reload
        assert @subscription.status == "approved"
    end
    
    test "PATCH #update should redirect_to :show with valid attributes" do
        params = { 
            status: :approved
        }
        patch :update, params: { id: @subscription.id, subscription: params }
        assert_redirected_to subscription_path(@subscription.id)
    end
    
    test "PATCH #update should render :edit with invalid attributes" do
        params = { 
            status: ""
        }
        patch :update, params: { id: @subscription.id, subscription: params }
        assert_template :edit
    end

    test "PATCH #update should return 422 response with invalid attributes" do
        params = { 
            status: nil
        }
        patch :update, params: { id: @subscription.id, subscription: params }
        assert_response 422
    end

    test "PATCH #update should not update a subscription with invalid attributes" do
        params = { 
            status: ""
        }
        patch :update, params: { id: @subscription.id, subscription: params }
        @subscription.reload
        assert_not @subscription.status == nil
    end

    test "PATCH #update should not update the cover letter of a subscription" do
        params = { 
            cover_letter: "test"
        }
        patch :update, params: { id: @subscription.id, subscription: params }
        @subscription.reload
        assert_not @subscription.cover_letter == "test"
    end

    test "PATCH #update should not update a subscription without permission" do
        sign_in(users(:user_9))
        params = { 
            status: :approved
        }
        patch :update, params: {id: @subscription.id, subscription: params }
        @subscription.reload
        assert @subscription.status != "approved"
    end

    test "PATCH #update should return 302 response without permission" do
        sign_in(users(:user_9))
        params = { 
            status: :approved
        }
        patch :update, params: {id: @subscription.id, subscription: params }
        assert_response 302
        # assert_redirected_to root_path()
    end

end
