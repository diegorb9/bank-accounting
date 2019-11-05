# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    subject { build(:customer) }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:document) }
    it { is_expected.to validate_uniqueness_of(:document).case_insensitive }
    it { is_expected.to allow_value('999009').for(:document) }
    it { is_expected.not_to allow_value('a999009,').for(:document) }
  end

  describe 'Associations' do
    it { is_expected.to have_one(:account).dependent(:restrict_with_error) }
  end

  describe 'Callbacks' do
    let(:customer) { build(:customer) }
    let(:account)  { build(:account, customer: customer) }

    before do
      allow(AccessTokenGenerator).to receive(:generate).and_return('QWEASD')
      allow(customer).to receive(:build_account).and_return(account)
    end

    describe 'before_create' do
      it 'generates and assigns an access token' do
        customer.run_callbacks :create
        expect(customer.access_token).to eql('QWEASD')
      end

      it 'builds an account' do
        customer.run_callbacks :create
        expect(customer.account).to eql(account)
      end
    end
  end
end
