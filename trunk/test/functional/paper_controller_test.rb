require File.dirname(__FILE__) + '/../test_helper'
require 'paper_controller'

# Re-raise errors caught by the controller.
class PaperController; def rescue_action(e) raise e end; end

class PaperControllerTest < Test::Unit::TestCase
  def setup
    @controller = PaperController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
