require File.dirname(__FILE__) + '/../test_helper'
require 'biblioteca_controller'

# Re-raise errors caught by the controller.
class BibliotecaController; def rescue_action(e) raise e end; end

class BibliotecaControllerTest < Test::Unit::TestCase
  def setup
    @controller = BibliotecaController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
