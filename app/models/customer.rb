# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :name, presence: true
  validates :document, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: /\A\d+\z/ }

  has_one :account, dependent: :restrict_with_error

  before_create :set_access_token
  before_create { build_account }

  private

  def set_access_token
    self.access_token = AccessTokenGenerator.generate
  end
end
