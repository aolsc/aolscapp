require 'test_helper'

class MemberCourseInterestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_course_interests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_course_interest" do
    assert_difference('MemberCourseInterest.count') do
      post :create, :member_course_interest => { }
    end

    assert_redirected_to member_course_interest_path(assigns(:member_course_interest))
  end

  test "should show member_course_interest" do
    get :show, :id => member_course_interests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => member_course_interests(:one).to_param
    assert_response :success
  end

  test "should update member_course_interest" do
    put :update, :id => member_course_interests(:one).to_param, :member_course_interest => { }
    assert_redirected_to member_course_interest_path(assigns(:member_course_interest))
  end

  test "should destroy member_course_interest" do
    assert_difference('MemberCourseInterest.count', -1) do
      delete :destroy, :id => member_course_interests(:one).to_param
    end

    assert_redirected_to member_course_interests_path
  end
end
