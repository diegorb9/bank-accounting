# frozen_string_literal: true

class AccountRepository
  class << self
    def balance_of(account)
      account
        .account_movements
        .order('total')
        .select(
          'SUM(CASE WHEN operator = 0 THEN amount ELSE 0 END) - ' \
          'SUM(CASE WHEN operator = 1 THEN amount ELSE 0 END) as total'
        ).first.total.to_f
    end

    def increase_balance(destination_account, amount)
      destination_account.account_movements.create!(
        operator: :addition, amount: amount
      )
    end

    def decrease_balance(source_account, amount)
      source_account.account_movements.create!(
        operator: :subtraction, amount: amount
      )
    end
  end
end
