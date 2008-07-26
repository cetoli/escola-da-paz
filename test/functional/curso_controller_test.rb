require File.dirname(__FILE__) + '/../test_helper'
require 'curso_controller'

# Re-raise errors caught by the controller.
class CursoController; def rescue_action(e) raise e end; end

class CursoControllerTest < Test::Unit::TestCase
  def setup
    @controller = CursoController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
