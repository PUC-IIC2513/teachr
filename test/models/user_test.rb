require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should changed state to invalid" do
    user = users(:jane)
    user.validated = true
    user.validation_hash = nil
    user.save
    
    assert user.validated
    assert_nil user.validation_hash
    
    user.email = "otro_#{user.email}"
    user.save
    
    refute user.validated, "user should be invalidated"
    refute_nil user.validation_hash
    
  end
end
