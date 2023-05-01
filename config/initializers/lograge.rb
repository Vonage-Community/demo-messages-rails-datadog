#config/initializers/lograge.rb

Rails.application.configure do
  # Lograge config
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.colorize_logging = false

  # Log to a dedicated file
  config.lograge.logger = ActiveSupport::Logger.new(Rails.root.join('log', "#{Rails.env}.log"))

  # This is useful if you want to log query parameters
  config.lograge.custom_options = lambda do |event|
      { :ddsource => 'ruby',
        :params => event.payload[:params].reject { |k| %w(controller action).include? k }
      }
  end
end
