ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name      => "mangapadapp@gmail.com",
  :password       => "MKV_PASSWORD_SIMPLE",
  :address        => "smtp.gmail.com",
  :enable_starttls_auto => true,
  :authentication => :plain,
  :port           => 587
}