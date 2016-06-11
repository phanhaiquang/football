require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  setup do
    @match = matches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create match" do
    assert_difference('Match.count') do
      post :create, match: { mainscore1: @match.mainscore1, mainscore2: @match.mainscore2, subscore1: @match.subscore1, subscore2: @match.subscore2, team1_id: @match.team1_id, team2_id: @match.team2_id }
    end

    assert_redirected_to match_path(assigns(:match))
  end

  test "should show match" do
    get :show, id: @match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @match
    assert_response :success
  end

  test "should update match" do
    patch :update, id: @match, match: { mainscore1: @match.mainscore1, mainscore2: @match.mainscore2, subscore1: @match.subscore1, subscore2: @match.subscore2, team1_id: @match.team1_id, team2: @match.team2_id }
    assert_redirected_to match_path(assigns(:match))
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete :destroy, id: @match
    end

    assert_redirected_to matches_path
  end
end
