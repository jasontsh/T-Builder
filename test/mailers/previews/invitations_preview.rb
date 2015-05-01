# Preview all emails at http://localhost:3000/rails/mailers/invitations
class InvitationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invitations/new_invite
  def new_invite
    Invitations.new_invite
  end

end
