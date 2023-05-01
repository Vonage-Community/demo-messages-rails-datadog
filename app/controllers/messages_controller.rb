class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index; end

  def send_message
    number = params[:number]
    message = params[:message]

    client = Vonage::Client.new(application_id: ENV['VONAGE_APPLICATION_ID'], private_key: ENV['VONAGE_PRIVATE_KEY_PATH'])

    text = Vonage::Messaging::Message.sms(message: message)

    begin
      client.messaging.send(to: number, from: 'Vonage', **text)
      redirect_to '/', notice: "Your message was sent"
    rescue => exception
      redirect_to '/', alert: "Sorry, there was a problem"
    end
  end

  def status
    log_data = {type: "Vonage API status", data: params}.to_json
    logger.info log_data
    head :ok
  end
end
