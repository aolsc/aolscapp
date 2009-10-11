require 'test_helper'

class MemberCoursesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_course" do
    assert_difference('MemberCourse.count') do
      post :create, :member_course => { }
    end

    assert_redirected_to member_course_path(assigns(:member_course))
  end

  test "should show member_course" do
    get :show, :id => member_courses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => member_courses(:one).to_param
    assert_response :success
  end

  test "should update member_course" do
    put :update, :id => member_courses(:one).to_param, :member_course => { }
    assert_redirected_to member_course_path(assigns(:member_course))
  end

  test "should destroy member_course" do
    assert_difference('MemberCourse.count', -1) do
      delete :destroy, :id => member_courses(:one).to_param
    end

    assert_redirected_to member_courses_path
  end
end
