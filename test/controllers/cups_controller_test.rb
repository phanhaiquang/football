require 'test_helper'

class CupsControllerTest < ActionController::TestCase
  setup do
    @cup = cups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cup" do
    assert_difference('Cup.count') do
      post :create, cup: { end_date: @cup.end_date, host: @cup.host, logo: @cup.logo, name: @cup.name, start_date: @cup.start_date }
    end

    assert_redirected_to cup_path(assigns(:cup))
  end

  test "should show cup" do
    get :show, id: @cup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cup
    assert_response :success
  end

  test "should update cup" do
    patch :update, id: @cup, cup: { end_date: @cup.end_date, host: @cup.host, logo: @cup.logo, name: @cup.name, start_date: @cup.start_date }
    assert_redirected_to cup_path(assigns(:cup))
  end

  test "should destroy cup" do
    assert_difference('Cup.count', -1) do
      delete :destroy, id: @cup
    end

    assert_redirected_to cups_path
  end
end
