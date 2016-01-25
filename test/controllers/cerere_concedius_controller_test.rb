require 'test_helper'

class CerereConcediusControllerTest < ActionController::TestCase
  setup do
    @cerere_concediu = cerere_concedius(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cerere_concedius)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cerere_concediu" do
    assert_difference('CerereConcediu.count') do
      post :create, cerere_concediu: { aprobata: @cerere_concediu.aprobata, data_inceput: @cerere_concediu.data_inceput, data_sfarsit: @cerere_concediu.data_sfarsit, user_id: @cerere_concediu.user_id }
    end

    assert_redirected_to cerere_concediu_path(assigns(:cerere_concediu))
  end

  test "should show cerere_concediu" do
    get :show, id: @cerere_concediu
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cerere_concediu
    assert_response :success
  end

  test "should update cerere_concediu" do
    patch :update, id: @cerere_concediu, cerere_concediu: { aprobata: @cerere_concediu.aprobata, data_inceput: @cerere_concediu.data_inceput, data_sfarsit: @cerere_concediu.data_sfarsit, user_id: @cerere_concediu.user_id }
    assert_redirected_to cerere_concediu_path(assigns(:cerere_concediu))
  end

  test "should destroy cerere_concediu" do
    assert_difference('CerereConcediu.count', -1) do
      delete :destroy, id: @cerere_concediu
    end

    assert_redirected_to cerere_concedius_path
  end
end
