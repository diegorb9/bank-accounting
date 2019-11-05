# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/accounts/:account_id', type: :request do
  it_behaves_like 'unauthorizable request', :get,
                  :api_v1_account_path, account_id: 1

  let(:customer) { create(:customer) }
  let(:account)  { customer.account }
  let(:response_body) { json(response.body) }

  context 'when success' do
    before do
      account.account_movements.create([
                                         { operator: 'addition', amount: 100.0 },
                                         { operator: 'addition', amount: 192.12 },
                                         { operator: 'subtraction', amount: 12.39 }
                                       ])
    end

    it 'returns serialized account with its balance' do
      get api_v1_account_path(account), headers: basic_headers(customer.access_token)

      expect(response_body).to eql(
        data: {
          attributes: {
            balance: 279.73,
            customer_id: customer.id
          },
          id: customer.id.to_s,
          type: 'account'
        }
      )
    end
  end
end
