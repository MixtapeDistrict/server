require 'test_helper'

class MediumCommentsControllerTest < ActionController::TestCase
  setup do
    @medium_comment = medium_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medium_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medium_comment" do
    assert_difference('MediumComment.count') do
      post :create, medium_comment: { comment_id: @medium_comment.comment_id, medium_id: @medium_comment.medium_id }
    end

    assert_redirected_to medium_comment_path(assigns(:medium_comment))
  end

  test "should show medium_comment" do
    get :show, id: @medium_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medium_comment
    assert_response :success
  end

  test "should update medium_comment" do
    patch :update, id: @medium_comment, medium_comment: { comment_id: @medium_comment.comment_id, medium_id: @medium_comment.medium_id }
    assert_redirected_to medium_comment_path(assigns(:medium_comment))
  end

  test "should destroy medium_comment" do
    assert_difference('MediumComment.count', -1) do
      delete :destroy, id: @medium_comment
    end

    assert_redirected_to medium_comments_path
  end
end
