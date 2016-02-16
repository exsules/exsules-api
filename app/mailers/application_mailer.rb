class ApplicationMailer < ActionMailer::Base
  default from: "#{Rails.configuration.exsules.emails.display_name} <#{Rails.configuration.exsules.emails.from}>"
  default 'Message-ID' => ->(v){ "<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@#{Rails.application.secrets.smtp_domain}>" }
  default reply_to: Rails.configuration.exsules.emails.reply
  #layout 'mailer'
end
