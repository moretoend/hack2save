require "test_helper"

class InstitutionsControllerTest < ActionController::TestCase

    include Devise::Test::ControllerHelpers
    include FactoryGirl::Syntax::Methods

    def setup
        sign_in create(:user)
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

end
