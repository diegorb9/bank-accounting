# frozen_string_literal: true

require 'rails_helper'

module Transfers
  RSpec.describe CreateService do
    subject(:service) { described_class.new(form, repository) }

    let(:repository) { double(:repository) }
    let(:source_account) { double(:source_account) }
    let(:destination_account) { double(:destination_account) }

    describe '#perform' do
      context 'when success' do
        let(:form) do
          double(
            :form,
            errors: [], source_account_id: 42, destination_account_id: 99, amount: 20.2
          )
        end

        it "doesn't assigns error when there is sufficient account's balance" do
          expect(form).to receive(:valid?).once.and_return(true)
          expect(Account).to receive(:find).with(42).once.and_return(source_account)
          expect(Account).to receive(:find).with(99).once.and_return(destination_account)
          expect(source_account).to receive(:with_lock).once.and_yield
          expect(repository).to receive(:balance_of).once.with(source_account).and_return(50.0)
          expect(repository).to receive(:increase_balance).once.with(destination_account, 20.2)
          expect(repository).to receive(:decrease_balance).once.with(source_account, 20.2)
          subject.perform

          expect(subject.errors).to be_blank
        end
      end

      context 'when failure' do
        let(:form) do
          double(:form, source_account_id: 42, amount: 20.2, errors: { foo: ['bar'] })
        end

        it "assigns error when there is not enough source account's balance" do
          expect(form).to receive(:valid?).once.and_return(true)
          expect(Account).to receive(:find).with(42).once.and_return(source_account)
          expect(source_account).to receive(:with_lock).once.and_yield
          expect(repository).to receive(:balance_of).once.with(source_account).and_return(10.0)
          expect(repository).not_to receive(:increase_balance).with(destination_account, 20.2)
          expect(repository).not_to receive(:decrease_balance).with(source_account, 20.2)
          subject.perform

          expect(subject.errors).to eql(source_account_id: ['saldo insuficiente'])
        end

        it "returns the errors when the form isn't valid" do
          expect(form).to receive(:valid?).once.and_return(false)
          expect(source_account).not_to receive(:with_lock).and_yield
          expect(repository).not_to receive(:balance_of).with(source_account)
          expect(repository).not_to receive(:increase_balance).with(destination_account, 20.2)
          expect(repository).not_to receive(:decrease_balance).with(source_account, 20.2)
          subject.perform

          expect(subject.errors).to eql(foo: ['bar'])
        end
      end
    end
  end
end
