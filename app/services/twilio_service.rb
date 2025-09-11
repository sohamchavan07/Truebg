require "twilio-ruby"

class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(
      Rails.application.credentials.dig(:twilio, :account_sid),
      Rails.application.credentials.dig(:twilio, :auth_token)
    )
    @from = Rails.application.credentials.dig(:twilio, :phone_number)
  end

  def send_otp(to, otp)
    @client.messages.create(
      from: @from,
      to: to,
      body: "Your OTP code is: #{otp}"
    )
  end
end
