# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :name, presence: true
  validates :access_token, presence: true, uniqueness: { case_sensitive: false }
  validates :document, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: /\A\d+\z/ }

  before_create :generate_access_token

  private

  def generate_access_token
    self.access_token = AccessTokenGenerator.generate
  end
end
