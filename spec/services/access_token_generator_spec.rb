# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessTokenGenerator do
  subject(:access_token) { described_class.generate }

  context 'when generated access_token is already in use' do
    it 'regenerates the access_token again' do
      expect(SecureRandom).to receive(:hex).once.with(10).and_return('foo')

      expect(Customer).to receive(:exists?).once
                                           .with(access_token: 'foo').and_return(true)

      expect(SecureRandom).to receive(:hex).once.with(10).and_return('bar')

      expect(Customer).to receive(:exists?).once
                                           .with(access_token: 'bar').and_return(false)

      expect(access_token).to eql('bar')
    end
  end
end
