unless Rails.env.test?
  Rails.application.config.action_mailer.delivery_method = :smtp
  Rails.application.config.action_mailer.raise_delivery_errors = true unless Rails.env.production?

  Rails.application.config.action_mailer.smtp_settings = {
    address: Rails.application.secrets.smtp_address,
    port:    Rails.application.secrets.smtp_port,
    user_name: Rails.application.secrets.smtp_user,
    password: Rails.application.secrets.smtp_password,
    domain: Rails.application.secrets.smtp_domain,
    authentication: Rails.application.secrets.smtp_authentication,
    enable_starttls_auto: Rails.application.secrets.smtp_startssl
    #openssl_verify_mode: Rails.application.secrets.smtp_openssl_verify
  }
end
