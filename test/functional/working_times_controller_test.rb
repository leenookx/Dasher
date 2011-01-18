require 'test_helper'

class WorkingTimesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:working_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create working_time" do
    assert_difference('WorkingTime.count') do
      post :create, :working_time => { }
    end

    assert_redirected_to working_time_path(assigns(:working_time))
  end

  test "should show working_time" do
    get :show, :id => working_times(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => working_times(:one).to_param
    assert_response :success
  end

  test "should update working_time" do
    put :update, :id => working_times(:one).to_param, :working_time => { }
    assert_redirected_to working_time_path(assigns(:working_time))
  end

  test "should destroy working_time" do
    assert_difference('WorkingTime.count', -1) do
      delete :destroy, :id => working_times(:one).to_param
    end

    assert_redirected_to working_times_path
  end
end
