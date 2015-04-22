ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              "smtp.mandrillapp.com",
  port:                 587,
  user_name:            ENV["MANDRILL_USERNAME"],
  password:             ENV["MANDRILL_API_KEY"]
  # domain:               "mail.google.com",
  # authentication:       :login,
  # enable_starttls_auto: true
}
