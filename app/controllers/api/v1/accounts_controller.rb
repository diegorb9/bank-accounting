# frozen_string_literal: true

module API
  module V1
    class AccountsController < ApplicationController
      def show
        render json: AccountSerializer.new(@current_account)
      end
    end
  end
end
