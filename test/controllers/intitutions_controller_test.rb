require "test_helper"

class InstitutionsControllerTest < ActionController::TestCase

    include Devise::Test::ControllerHelpers
    include FactoryGirl::Syntax::Methods

    def setup
        sign_in create(:user)
        @institution = create(:institution)
    end

    test "should get index" do
        get :index
        assert_response :success
    end

    test "should get new" do
        get :new
        assert_response :success
    end

    test "should create a new institution" do
        assert_difference('Institution.count') do
            institutions_params = attributes_for(:institution)
            post :create, params: { institution: institutions_params }
        end

        assert_equal 'Instituição criada com sucesso!', flash[:success]
        assert_redirected_to institution_path(Institution.last)
    end

    test "should get edit" do
        get :edit, params: {id: @institution}
        assert_response :success
    end

    test "should update institution" do
        patch :update, params: {id: @institution, institution: {name: "updated"} }
        @institution.reload
        assert_equal "updated", @institution.name
        assert_redirected_to institution_path(Institution.last)
        assert_equal 'Instituição atualizada!', flash[:success]
    end

    test "should show the institution" do
        get :show, params: {id: @institution}
        assert_response :success
    end

    test "should destroy the institution" do
        assert_difference('Institution.count', -1) do
            delete :destroy, params: {id: @institution}
        end
        assert_redirected_to institutions_path
        assert_equal 'Instituição deletada!', flash[:success]
    end

end
