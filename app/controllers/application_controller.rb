# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  private

  def authenticate!
    authenticate_with_http_token do |token, _|
      @current_account ||= fetch_account(token, params[:account_id])
    end || head(:unauthorized)
  end

  def fetch_account(token, id)
    Account.joins(:customer)
           .where('customers.access_token = ? AND accounts.id = ?', token, id)
           .first
  end
end
