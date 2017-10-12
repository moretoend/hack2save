require 'test_helper'

class JobActionsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:standard)
    sign_in @user
    @institution = institutions(:standard)
  end

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
    assert_redirected_to institution_jobs_path(@institution.id)
    follow_redirect!
    assert_response :success
  end

  test "can edit a job through institution" do
    get edit_institution_job_path(@institution, @institution.jobs.last)
    assert_response :success

    patch institution_job_path(@institution, @institution.jobs.last), params: { job: {title: "New name"} }
    @institution.reload

    assert @institution.jobs.last.title == "New name"
    assert_redirected_to institution_jobs_path(@institution.id)
    follow_redirect!
    assert_response :success
  end
end
