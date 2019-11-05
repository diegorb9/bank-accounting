# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/transfers', type: :request do
  it_behaves_like 'unauthorizable request', :post,
                  :api_v1_transfers_path, source_account_id: 1

  let(:requester_customer) { create(:customer, document: '0001') }
  let(:source_account) { requester_customer.account }

  let!(:account_movement) do
    create(:account_movement, account: source_account, amount: 100.0)
  end

  let(:recipient_customer) { create(:customer, document: '0002') }
  let(:destination_account)  { recipient_customer.account }

  let(:response_body) { json(response.body) }
  let(:headers) { basic_headers(requester_customer.access_token) }

  context 'when success' do
    let(:params) do
      {
        source_account_id: source_account.id,
        destination_account_id: destination_account.id,
        amount: 42.44
      }
    end

    it 'responds with :created' do
      post api_v1_transfers_path, params: params, headers: headers

      expect(response).to have_http_status(:created)
    end

    it 'creates the account_movements' do
      expect do
        post api_v1_transfers_path, params: params, headers: headers
      end.to change(AccountMovement, :count).by(2)
    end
  end

  context 'when failure' do
    context "when destination_account_id doesn't exists" do
      let(:params) do
        {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id + 12,
          amount: 42.44
        }
      end

      it 'responds with :unprocessable_entity' do
        post api_v1_transfers_path, params: params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors' do
        post api_v1_transfers_path, params: params, headers: headers

        expect(response_body).to eql(destination_account_id: ['não foi encontrada'])
      end
    end

    context "when there is not enough source account's balance" do
      let(:params) do
        {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 200.0
        }
      end

      it 'responds with :unprocessable_entity' do
        post api_v1_transfers_path, params: params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors' do
        post api_v1_transfers_path, params: params, headers: headers

        expect(response_body).to eql(source_account_id: ['saldo insuficiente'])
      end
    end

    context 'when parameters are invalid' do
      let(:params) do
        {
          source_account_id: source_account.id,
          destination_account_id: nil,
          amount: 0.0
        }
      end

      it 'responds with :unprocessable_entity' do
        post api_v1_transfers_path, params: params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors' do
        post api_v1_transfers_path, params: params, headers: headers

        expect(response_body).to eql(
          amount: ['deve ser maior que 0.0'],
          destination_account_id: ['não pode ficar em branco', 'não foi encontrada']
        )
      end
    end
  end
end
