require "test_helper"

class UserPlayTest < ActiveSupport::TestCase

  def user_play
    @user_play ||= UserPlay.new
  end

  def test_valid
    assert user_play.valid?
  end

end
