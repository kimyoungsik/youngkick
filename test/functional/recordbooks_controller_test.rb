require 'test_helper'

class RecordbooksControllerTest < ActionController::TestCase
  setup do
    @recordbook = recordbooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recordbooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recordbook" do
    assert_difference('Recordbook.count') do
      post :create, recordbook: @recordbook.attributes
    end

    assert_redirected_to recordbook_path(assigns(:recordbook))
  end

  test "should show recordbook" do
    get :show, id: @recordbook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recordbook
    assert_response :success
  end

  test "should update recordbook" do
    put :update, id: @recordbook, recordbook: @recordbook.attributes
    assert_redirected_to recordbook_path(assigns(:recordbook))
  end

  test "should destroy recordbook" do
    assert_difference('Recordbook.count', -1) do
      delete :destroy, id: @recordbook
    end

    assert_redirected_to recordbooks_path
  end
end
