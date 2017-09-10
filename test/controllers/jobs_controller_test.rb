require 'test_helper'

class JobsControllerTest < ActionController::TestCase


  include Devise::Test::ControllerHelpers


  def job_attributes
    Job.new(title: "Title", description: "Description", requirements: "responsability", 
            start_date: 1.month.from_now, end_date: 2.months.from_now,
            institution: institutions(:standard)).attributes.symbolize_keys
  end


  setup do
    @admin = permissions(:admin)
    @institution = institutions(:standard)
    @jobs = jobs(:job_0, :job_1, :job_2, :job_3, :job_4)
    @job = jobs(:job_3)
    sign_in(@admin.user)
  end


  test "GET #index should renders :index template" do
    get :index, params: { institution_id: @institution.id }
    assert_template :index
  end


  test "GET #index should return :success response" do
    get :index, params: { institution_id: @institution.id }
    assert_response :success
  end

  
  test "GET #index should return list of jobs of institution" do
    get :index, params: { institution_id: @institution.id }
    assert assigns(:jobs).sort == @jobs.sort
  end
  

  test "GET #new should renders :new template" do
    get :new, params: { institution_id: @institution.id }
    assert_template :new
  end


  test "GET #new should return :success response" do
    get :new, params: { institution_id: @institution.id }
    assert_response :success
  end


  test "POST #create should add a new job with valid attributes" do
    assert_difference("Job.count", 1) do
      post :create, params: { institution_id: @institution.id, job: job_attributes }
    end
  end
  
   
  test "POST #create should redirect_to :index with valid attributes" do
    post :create, params: { institution_id: @institution.id, job: job_attributes }
    new_job = assigns(:job)
    assert_redirected_to institution_jobs_path(new_job.institution.id)
  end


  test "POST #create should not add a job with invalid attributes" do
    job_params = job_attributes    
    job_params[:title] = ""
    assert_no_difference("Job.count") do
      post :create, params: { institution_id: @institution.id, job: job_params }
    end
  end
  
   
  test "POST #create should render :new with invalid attributes" do
    job_params = job_attributes 
    job_params[:title] = ""
    post :create, params: { institution_id: @institution.id, permission: job_params }
    assert_template :new
  end


  test "POST #create should return 422 response with invalid attributes" do
    job_params = job_attributes 
    job_params[:title] = ""
    post :create, params: { institution_id: @institution.id, permission: job_params }
    assert_response 422
  end


  test "GET #edit should renders :new template" do
    get :edit, params: { institution_id: @job.institution.id, id: @job.id }
    assert_template :edit
  end


  test "GET #edit should return :success response" do
    get :edit, params: { institution_id: @job.institution.id, id: @job.id }
    assert_response :success
  end


  test "GET #edit should assign :job" do
    get :edit, params: { institution_id: @job.institution.id, id: @job.id }
    assert assigns(:job) == @job
  end


  test "PATCH #update should update a job with valid attributes" do
    job_params = { title: "New Title" }
    inst_id = @job.institution_id
    patch :update, params: { institution_id: inst_id, id: @job.id, job: job_params }
    @job.reload
    assert @job.title == "New Title"
  end
  
   
  test "PATCH #update should redirect_to :index with valid attributes" do
    job_params = { title: "New Title" }
    inst_id = @job.institution_id
    patch :update, params: { institution_id: inst_id, id: @job.id, job: job_params }
    assert_redirected_to institution_jobs_path(@job.institution.id)
  end
  
   
  test "PATCH #update should render :edit with invalid attributes" do
    job_params = { title: "" }
    inst_id = @job.institution_id
    patch :update, params: { institution_id: inst_id, id: @job.id, job: job_params }    
    assert_template :edit
  end


  test "PATCH #update should return 422 response with invalid attributes" do
    job_params = { title: "" }
    inst_id = @job.institution_id
    patch :update, params: { institution_id: inst_id, id: @job.id, job: job_params }
    assert_response 422
  end


  test "PATCH #update should not update a job with invalid attributes" do
    job_params = { title: "" }
    inst_id = @job.institution_id
    patch :update, params: { institution_id: inst_id, id: @job.id, job: job_params }
    @job.reload
    assert_not @job.title == nil
  end


  test "DELETE #destroy should remove job" do
    assert_difference("Job.count", -1) do
      delete :destroy, params: { institution_id: @job.institution.id, id: @job.id }
    end
  end


  test "DELETE #destroy should redirect_to :index" do
    delete :destroy, params: { institution_id: @job.institution.id, id: @job.id }
    assert_redirected_to institution_jobs_path(@job.institution.id)
  end

end
