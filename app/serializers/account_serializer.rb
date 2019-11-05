# frozen_string_literal: true

class AccountSerializer
  include FastJsonapi::ObjectSerializer

  attributes :customer_id

  attribute :balance do |object|
    AccountRepository.balance_of(object)
  end
end
