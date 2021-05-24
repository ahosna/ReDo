require "test_helper"

class RedosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redo = redos(:one)
  end

  test "should get index" do
    get redos_url
    assert_response :success
  end

  test "should get new" do
    get new_redo_url
    assert_response :success
  end

  test "should create redo" do
    assert_difference('Redo.count') do
      post redos_url, params: { redo: { key: @redo.key, type: @redo.type, version: @redo.version } }
    end

    assert_redirected_to redo_url(Redo.last)
  end

  test "should show redo" do
    get redo_url(@redo)
    assert_response :success
  end

  test "should get edit" do
    get edit_redo_url(@redo)
    assert_response :success
  end

  test "should update redo" do
    patch redo_url(@redo), params: { redo: { key: @redo.key, type: @redo.type, version: @redo.version } }
    assert_redirected_to redo_url(@redo)
  end

  test "should destroy redo" do
    assert_difference('Redo.count', -1) do
      delete redo_url(@redo)
    end

    assert_redirected_to redos_url
  end
end
