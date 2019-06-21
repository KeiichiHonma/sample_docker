class NoticeMailer < ActionMailer::Base
  default from: "no-reply@sleepdays.jp"

  def contact_email(contact)
    @contact = contact
    mail(from: "\"Sleepdays\" <no-reply@sleepdays.jp>")
    mail subject: "[Sleepdays お問い合わせ]", to: @contact.email, bcc: ENV["NOTICE_MAIL_ADDRESS"]
  end
end
