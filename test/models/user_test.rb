require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user should invalidated and create a validation hash" do
    u = User.first
    u.validated = true
    u.validation_hash = nil
    u.save
    assert u.validated
    assert_nil u.validation_hash
    
    u.email = "another." + u.email
    u.save
    
    refute u.validated, "User is not invalidated when changing his email"
    refute_nil u.validation_hash, "User has not created a validation_hash after changing his email"
  end
end
