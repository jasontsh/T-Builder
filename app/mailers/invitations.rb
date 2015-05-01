class Invitations < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitations.new_invite.subject
  #
  def new_invite(from, to)
    @greeting = "Hi!"
    @from = from.name

    mail to: to.email
  end
end
