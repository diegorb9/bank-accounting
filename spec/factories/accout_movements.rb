# frozen_string_literal: true

FactoryBot.define do
  factory :account_movement do
    account
    amount { 12.99 }
    operator { 'addition' }

    trait :subtraction do
      operator { 'subtraction' }
    end
  end
end
