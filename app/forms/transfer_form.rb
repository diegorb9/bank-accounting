# frozen_string_literal: true

class TransferForm
  include ActiveModel::Model

  attr_accessor :source_account_id, :destination_account_id, :amount

  validates :source_account_id, :destination_account_id, presence: true
  validates :amount, numericality: { greater_than: 0.0 }

  validate :destination_account_existence

  private

  def destination_account_existence
    return if Account.exists?(id: destination_account_id)

    errors.add(:destination_account_id, :not_found)
  end
end
