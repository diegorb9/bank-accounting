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

  describe 'Callbacks' do
    describe ':before_create' do
      let(:customer) { build(:customer) }

      it 'generates and assigns an access token' do
        expect(AccessTokenGenerator).to receive(:generate).once.and_return('QWEASD')
        customer.run_callbacks :create
        expect(customer.access_token).to eql('QWEASD')
      end
    end
  end
end
