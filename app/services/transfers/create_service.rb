# frozen_string_literal: true

module Transfers
  class CreateService
    InsufficientBalance = Class.new(StandardError)

    attr_reader :errors

    def initialize(form, repository)
      @form = form
      @repository = repository
      @errors = []
    end

    def perform
      @errors = form.errors unless form.valid? && perform_transfer
    rescue InsufficientBalance
      @errors = { source_account_id: [insufficient_balance_error] }
    end

    private

    attr_reader :form, :repository

    def source_account
      @source_account ||= Account.find(form.source_account_id)
    end

    def destination_account
      @destination_account ||= Account.find(form.destination_account_id)
    end

    def perform_transfer
      source_account.with_lock do
        raise InsufficientBalance if insufficient_balance?

        repository.increase_balance(destination_account, amount)
        repository.decrease_balance(source_account, amount)
      end
    end

    def insufficient_balance?
      repository.balance_of(source_account) <= amount.to_f
    end

    def insufficient_balance_error
      I18n.t(
        'activemodel.errors.models.transfer_form.attributes.source_account_id' \
        '.insufficient_balance'
      )
    end

    def amount
      @amount ||= form.amount
    end
  end
end
