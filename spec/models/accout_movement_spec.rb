# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountMovement, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0.0) }

    it { is_expected.to define_enum_for(:operator).with_values(%w[addition subtraction]) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:account) }
  end
end
