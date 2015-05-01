require 'test_helper'

class InvitationsTest < ActionMailer::TestCase
  test "new_invite" do
    mail = Invitations.new_invite
    assert_equal "New invite", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
