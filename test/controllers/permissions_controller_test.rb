require 'test_helper'

class PermissionsControllerTest < ActionController::TestCase


  include Devise::Test::ControllerHelpers


  setup do
    @institution = institutions(:standard)
    @admin = permissions(:admin)
    @approver = permissions(:approver)
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

  
  test "GET #index should return list of permissions of institution" do
    get :index, params: { institution_id: @institution.id }
    assert assigns(:permissions).sort == [@admin, @approver].sort
  end
  

  test "GET #new should renders :new template" do
    get :new, params: { institution_id: @institution.id }
    assert_template :new
  end


  test "GET #new should return :success response" do
    get :new, params: { institution_id: @institution.id }
    assert_response :success
  end


  test "POST #create should add a new permission with valid attributes" do
    approver_params = { user_id: users(:user_3).id, profile: :approver }
    assert_difference("Permission.count", 1) do
      post :create, params: { institution_id: @institution.id, permission: approver_params }
    end
  end
  
   
  test "POST #create should redirect_to :index with valid attributes" do
    approver_params = { user_id: users(:user_4).id, profile: :approver }
    post :create, params: { institution_id: @institution.id, permission: approver_params }
    new_permission = assigns(:permission)
    assert_redirected_to institution_permissions_path(new_permission.institution.id)
  end


  test "POST #create should not add a permission with invalid attributes" do
    approver_params = { user_id: users(:user_6).id, profile: "" }
    assert_no_difference("Permission.count") do
      post :create, params: { institution_id: @institution.id, permission: approver_params }
    end
  end
  
   
  test "POST #create should render :new with invalid attributes" do
    approver_params = { user_id: users(:user_7).id, profile: "" }
    post :create, params: { institution_id: @institution.id, permission: approver_params }
    assert_template :new
  end


  test "POST #create should return 422 response with invalid attributes" do
    approver_params = { user_id: users(:user_8).id, profile: "" }
    post :create, params: { institution_id: @institution.id, permission: approver_params }
    assert_response 422
  end


  test "GET #edit should renders :new template" do
    get :edit, params: { institution_id: @approver.institution.id, id: @approver.id }
    assert_template :edit
  end


  test "GET #edit should return :success response" do
    get :edit, params: { institution_id: @approver.institution.id, id: @approver.id }
    assert_response :success
  end


  test "GET #edit should assign :permission" do
    get :edit, params: { institution_id: @approver.institution.id, id: @approver.id }
    assert assigns(:permission) == @approver
  end


  test "PATCH #update should update a permission with valid attributes" do
    approver_params = { profile: :admin }
    inst_id = @approver.institution_id
    patch :update, params: { institution_id: inst_id, id: @approver.id, permission: approver_params }
    @approver.reload
    assert @approver.profile == "admin"
  end
  
   
  test "PATCH #update should redirect_to :index with valid attributes" do
    approver_params = { profile: :admin }
    inst_id = @approver.institution_id
    patch :update, params: { institution_id: inst_id, id: @approver.id, permission: approver_params }
    assert_redirected_to institution_permissions_path(@approver.institution.id)
  end
  
   
  test "PATCH #update should render :edit with invalid attributes" do
    approver_params = { profile: "" }
    inst_id = @approver.institution_id
    patch :update, params: { institution_id: inst_id, id: @approver.id, permission: approver_params }    
    assert_template :edit
  end


  test "PATCH #update should return 422 response with invalid attributes" do
    approver_params = { profile: "" }
    inst_id = @approver.institution_id
    patch :update, params: { institution_id: inst_id, id: @approver.id, permission: approver_params }
    assert_response 422
  end


  test "PATCH #update should not update a permission with valid attributes" do
    approver_params = { profile: "" }
    inst_id = @approver.institution_id
    patch :update, params: { institution_id: inst_id, id: @approver.id, permission: approver_params }
    @approver.reload
    assert_not @approver.profile == nil
  end


  test "DELETE #destroy should remove permission" do
    assert_difference("Permission.count", -1) do
      delete :destroy, params: { institution_id: @approver.institution.id, id: @approver.id }
    end
  end


  test "PATCH #update should redirect_to :index" do
    delete :destroy, params: { institution_id: @approver.institution.id, id: @approver.id }
    assert_redirected_to institution_permissions_path(@approver.institution.id)
  end

end
