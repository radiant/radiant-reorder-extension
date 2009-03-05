require File.dirname(__FILE__) + "/../test_helper"

Admin::PagesController.class_eval { def rescue_action(e); raise(e); end }

class PagesControllerExtensions < Test::Unit::TestCase
  dataset :users, :pages_with_positions

  def setup
    @controller = Admin::PagesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    login_as(:existing)
  end
  
  def test_move_higher
    assert_difference 'pages(:documentation).position', -1 do
      post :move_higher, :id => pages(:documentation).id
      assert_response :redirect
      assert_equal pages(:documentation).id, assigns(:page).id
      pages(:documentation).reload
    end
  end
  
  def test_move_lower
    assert_difference 'pages(:documentation).position', 1 do
      post :move_lower, :id => pages(:documentation).id
      assert_response :redirect
      assert_equal pages(:documentation).id, assigns(:page).id
      pages(:documentation).reload
    end
  end

  def test_move_to_top
    post :move_to_top, :id => pages(:documentation).id
    assert_response :redirect
    assert_equal pages(:documentation).id, assigns(:page).id
    assert_equal 1, assigns(:page).position
  end

  def test_move_to_bottom
    post :move_to_bottom, :id => pages(:documentation).id
    assert_response :redirect
    assert_equal pages(:documentation).id, assigns(:page).id
    assert_equal 6, assigns(:page).position
  end

  def test_requires_login
    logout
    %w{move_higher move_lower move_to_top move_to_bottom}.each do |action|
      post action, :id => pages(:documentation).id
      assert_response :redirect
      assert_redirected_to login_url
    end
  end
end
