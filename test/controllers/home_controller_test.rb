require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Test home action.
  test "should get home" do
    # Test RESTful route.
    get root_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'Welcome!'
  end

  # Test contact action.
  test "should get contact" do
    # Test RESTful route.
    get contact_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'Contact Us'
    assert_select 'p', 'We\'d love to hear your feedback!'
  end

  # Test request_contact action when no email supplied.
  test "should post request contact but no email" do
    # Call action without supplying email.
    post request_contact_url
    assert_response :redirect
    assert_not_empty flash[:alert]
    assert_nil flash[:notice]
  end

  # Test request_contact action when email provided.
  test "should post request contact" do
    # Call action and supply email as parameter.
    post request_contact_url, params:
      {name: "Amaan", email: "amaan@me.com",
      telephone: "1234567890", message: "Hello"}
    assert_response :redirect
      assert_nil flash[:alert]
      assert_not_empty flash[:notice]
  end

end
