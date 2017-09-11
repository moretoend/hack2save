require 'test_helper'

class InstitutionActionsTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:standard)
    sign_in @user
    @institution = institutions(:standard)
  end


  test "can create an institution" do 
    get new_institution_path
    assert_response :success

    assert_difference('Institution.count') do
      post institutions_path, 
           params: { institution: { name: "Test", description: "Testing", category: "Any" } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end


  test "can update an institution" do
    get edit_institution_path(@institution)
    assert_response :success

    patch institution_path(@institution), params: { institution: { name: "New name" } }  
    @institution.reload

    assert @institution.name == "New name"
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end


  test "can delete an institution" do
    get institutions_path
    assert_response :success

    assert_difference('Institution.count', -1) do
      delete institution_path(@institution)
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

end

