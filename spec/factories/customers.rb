# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { 'Luke Skywalker' }
    document { '09998800' }
    access_token { '79ed1bda0f7d6afe88bb' }
  end
end
