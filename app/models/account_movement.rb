# frozen_string_literal: true

class AccountMovement < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true, numericality: { greater_than: 0.0 }

  enum operator: { addition: 0, subtraction: 1 }
end
