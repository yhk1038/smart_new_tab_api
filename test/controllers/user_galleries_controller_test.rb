require 'test_helper'

class UserGalleriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_gallery = user_galleries(:one)
  end

  test "should get index" do
    get user_galleries_url, as: :json
    assert_response :success
  end

  test "should create user_gallery" do
    assert_difference('UserGallery.count') do
      post user_galleries_url, params: { user_gallery: { references: @user_gallery.references, references: @user_gallery.references } }, as: :json
    end

    assert_response 201
  end

  test "should show user_gallery" do
    get user_gallery_url(@user_gallery), as: :json
    assert_response :success
  end

  test "should update user_gallery" do
    patch user_gallery_url(@user_gallery), params: { user_gallery: { references: @user_gallery.references, references: @user_gallery.references } }, as: :json
    assert_response 200
  end

  test "should destroy user_gallery" do
    assert_difference('UserGallery.count', -1) do
      delete user_gallery_url(@user_gallery), as: :json
    end

    assert_response 204
  end
end
