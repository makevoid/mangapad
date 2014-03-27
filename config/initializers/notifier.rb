if Rails.env == "production"
  require 'exception_notifier'
  Mangapad::Application.config.middleware.use ExceptionNotifier,
      :email_prefix => "[MangaPad] ",
      :sender_address => %{"MangaPad" <mangapadapp@gmail.com>},
      :exception_recipients => %w{makevoid@gmail.com}
end