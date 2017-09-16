require 'test_helper'

class AproveSubscriptionTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    setup do
        @user = users(:standard)
        sign_in(@user)
        @institution = institutions(:standard)
        @institution.permissions.create(user: @user, profile: :owner)
        @job_1 = @institution.jobs.create(
          title: "Job 1",
          description: "Description Job 1",
          requirements: "Requirements Job",
          start_date: Date.today,
          end_date: Date.today + 5.days
        )
        @subscription = @job_1.subscriptions.create(
            cover_letter: "Cover Letter",
            user: users(:user_1)
        )
        @subscription.update_attributes(status: 2)
    end

    test "list subscriptions of one institutions" do
        get institution_subscriptions_path(@institution.id)
        assert_response :success
        assert_select "h4", @institution.name

        assert_select "td", @job_1.title 
        assert_select "td", @subscription.user.name

        assert_select "td", "Job 1"

        assert_select "div.switch input[type=\"checkbox\"]", 2
        assert_select "div.switch input[type=\"checkbox\"][checked]", 1
    end
    
    test "filter list subscriptions of one institutions" do
        get institution_subscriptions_path(@institution.id)
        assert_select "div.switch input[type=\"checkbox\"]", 2
        get institution_subscriptions_path(@institution.id, :search => 'Job 1')
        assert_response :success
        assert_select "div.switch input[type=\"checkbox\"]", 1
    end
end
