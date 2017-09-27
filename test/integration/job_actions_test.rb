require 'test_helper'

class JobActionsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:standard)
    sign_in @user
    @institution = institutions(:standard)
  end

  # Use separate examples per route / case
  test "can fill in form to create a new job" do
    get new_institution_job_path(@institution)
    assert_response :success
  end

  test "can create a job through institution" do
    assert_difference ->{ @institution.jobs.count } do
      post institution_jobs_path(@institution), 
          params: { 
            job: {
               title: "Desenvolvedor", 
               description: "Ruby",
               requirements: "rspec and capybara", 
               start_date: Date.today, 
               end_date: Date.today + 5.days
            }
          }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
