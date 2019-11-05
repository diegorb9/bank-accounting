# frozen_string_literal: true

class AccountRepository
  class << self
    def balance_of(account)
      account
        .account_movements
        .order('total')
        .select(
          'SUM(CASE WHEN operator=0 then amount end) - ' \
          'SUM(CASE WHEN operator=1 then amount end) as total'
        ).first.total.to_f
    end
  end
end
