# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransferForm, type: :model do
  subject(:form) { described_class.new(**params) }

  let(:params) do
    {
      source_account_id: 42,
      destination_account_id: 87,
      amount: 42.44
    }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:source_account_id) }
    it { is_expected.to validate_presence_of(:destination_account_id) }

    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0.0) }

    describe 'destination_account_existence' do
      let(:error_message) { 'não foi encontrada' }

      context 'when valid' do
        it "doesn't return an error message" do
          expect(Account).to receive(:exists?).once.with(id: 87).and_return(true)
          form.valid?

          expect(form.errors[:destination_account_id]).not_to include(error_message)
        end
      end

      context 'when invalid' do
        it 'returns an error message' do
          expect(Account).to receive(:exists?).once.with(id: 87).and_return(false)
          form.valid?

          expect(form.errors[:destination_account_id]).to include(error_message)
        end
      end
    end
  end
end
