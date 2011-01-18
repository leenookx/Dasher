require 'test_helper'

class ProjectRolesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_role" do
    assert_difference('ProjectRole.count') do
      post :create, :project_role => { }
    end

    assert_redirected_to project_role_path(assigns(:project_role))
  end

  test "should show project_role" do
    get :show, :id => project_roles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => project_roles(:one).to_param
    assert_response :success
  end

  test "should update project_role" do
    put :update, :id => project_roles(:one).to_param, :project_role => { }
    assert_redirected_to project_role_path(assigns(:project_role))
  end

  test "should destroy project_role" do
    assert_difference('ProjectRole.count', -1) do
      delete :destroy, :id => project_roles(:one).to_param
    end

    assert_redirected_to project_roles_path
  end
end
