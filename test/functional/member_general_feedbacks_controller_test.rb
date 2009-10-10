require 'test_helper'

class MemberGeneralFeedbacksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_general_feedbacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_general_feedback" do
    assert_difference('MemberGeneralFeedback.count') do
      post :create, :member_general_feedback => { }
    end

    assert_redirected_to member_general_feedback_path(assigns(:member_general_feedback))
  end

  test "should show member_general_feedback" do
    get :show, :id => member_general_feedbacks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => member_general_feedbacks(:one).to_param
    assert_response :success
  end

  test "should update member_general_feedback" do
    put :update, :id => member_general_feedbacks(:one).to_param, :member_general_feedback => { }
    assert_redirected_to member_general_feedback_path(assigns(:member_general_feedback))
  end

  test "should destroy member_general_feedback" do
    assert_difference('MemberGeneralFeedback.count', -1) do
      delete :destroy, :id => member_general_feedbacks(:one).to_param
    end

    assert_redirected_to member_general_feedbacks_path
  end
end
