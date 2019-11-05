# frozen_string_literal: true

module API
  module V1
    class TransfersController < ApplicationController
      def create
        result = Transfers::CreateService.new(transfer_form, AccountRepository)
        result.perform

        if result.errors.blank?
          render status: :created
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      private

      def transfer_params
        params.require(:transfer).permit(
          :source_account_id,
          :destination_account_id,
          :amount
        )
      end

      def transfer_form
        TransferForm.new(
          source_account_id: params[:source_account_id],
          destination_account_id: params[:destination_account_id],
          amount: params[:amount]
        )
      end
    end
  end
end
