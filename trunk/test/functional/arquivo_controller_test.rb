require File.dirname(__FILE__) + '/../test_helper'
require 'arquivo_controller'

# Re-raise errors caught by the controller.
class ArquivoController; def rescue_action(e) raise e end; end

class ArquivoControllerTest < Test::Unit::TestCase
  def setup
    @controller = ArquivoController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
