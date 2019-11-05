# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountSerializer do
  let(:account) { build_stubbed(:account) }

  subject(:serialized) { described_class.new(account).serializable_hash }

  it 'returns serialized account' do
    expect(AccountRepository).to receive(:balance_of)
      .once.with(account).and_return(89.9)

    expect(serialized).to eql(
      data: {
        attributes: {
          customer_id: account.customer_id,
          balance: 89.9
        },
        id: account.id.to_s,
        type: :account
      }
    )
  end
end
