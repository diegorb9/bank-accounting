# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountRepository do
  describe '.balance_of' do
    subject(:repository) { described_class }

    let(:account) { double(:account) }
    let(:account_movements) { double(:account_movements) }

    it 'returns balance according to account movements' do
      expect(account).to receive_message_chain(:account_movements, :order)
        .with('total').and_return(account_movements)

      expect(account_movements).to receive(:select).once.with(
        'SUM(CASE WHEN operator = 0 THEN amount ELSE 0 END) - ' \
        'SUM(CASE WHEN operator = 1 THEN amount ELSE 0 END) as total'
      ).and_return(account_movements)

      expect(account_movements).to receive_message_chain(:first, :total, :to_f)
        .and_return(42.44)

      expect(repository.balance_of(account)).to eql(42.44)
    end
  end
end
