# frozen_string_literal: true

module AccessTokenGenerator
  def self.generate
    loop do
      access_token = SecureRandom.hex(10)
      break access_token unless Customer.exists?(access_token: access_token)
    end
  end
end
