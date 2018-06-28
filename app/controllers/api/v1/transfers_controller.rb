# frozen_string_literal: true

module Api
  module V1
    class TransfersController < ApplicationController
      PERMITTED_PARAMS = %i[
        uid
        ammount
        origin_id
        destination_id
      ].freeze

      # exposes
      expose(:transfer) { Transfer.all }
      expose(:transfer, attributes: :transfer_attributes)

      # GET /transfer
      def index
        json_response(transfer)
      end

      # POST /transfer
      def create
        transfer = CreateTransfer.new.create(hash_params)
        json_response(transfer, :created)
      rescue StandardError => error
        json_response(error.message, :unprocessable_entity)
      end

      private

      def hash_params
        transfer_params.to_h.symbolize_keys
      end

      def transfer_params
        params.require(:transfer).permit(PERMITTED_PARAMS)
      end
    end
  end
end
