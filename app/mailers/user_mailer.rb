class UserMailer < ActionMailer::Base
  default :from => "\"Geoflux\" <info@geoflux.com>"
  default :template_path => "mailer"
  default "Message-ID"=>"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@geoflux.com>"

  layout 'emails/standard'
  helper ApplicationHelper

  before_filter :add_inline_attachments!

  def estimate_request(estimate_request)
    @estimate_request = estimate_request
    mail(:to => @estimate_request.contact.email, :subject => estimate_request.email_subject)
  end

  private
  def add_inline_attachments!
    attachments.inline["logo-geoflux.gif"] = File.read("app/assets/images/mailer/logo-geoflux.gif")
  end


end