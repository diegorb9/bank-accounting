# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Validations' do
    it { is_expected.to belong_to(:customer) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:account_movements).dependent(:destroy) }
  end
end
