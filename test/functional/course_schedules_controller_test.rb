require 'test_helper'

class CourseSchedulesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_schedule" do
    assert_difference('CourseSchedule.count') do
      post :create, :course_schedule => { }
    end

    assert_redirected_to course_schedule_path(assigns(:course_schedule))
  end

  test "should show course_schedule" do
    get :show, :id => course_schedules(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => course_schedules(:one).to_param
    assert_response :success
  end

  test "should update course_schedule" do
    put :update, :id => course_schedules(:one).to_param, :course_schedule => { }
    assert_redirected_to course_schedule_path(assigns(:course_schedule))
  end

  test "should destroy course_schedule" do
    assert_difference('CourseSchedule.count', -1) do
      delete :destroy, :id => course_schedules(:one).to_param
    end

    assert_redirected_to course_schedules_path
  end
end
