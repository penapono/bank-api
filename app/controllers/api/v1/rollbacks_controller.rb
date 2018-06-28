# frozen_string_literal: true

module Api
  module V1
    class RollbacksController < ApplicationController
      PERMITTED_PARAMS = %i[
        transfer_id
      ].freeze

      # POST /rollbacks
      def create
        rollback = RollbackTransfer.new.rollback(hash_params)
        json_response(rollback, :created)
      rescue StandardError => error
        json_response(error.message, :unprocessable_entity)
      end

      private

      def hash_params
        rollback_params.to_h.symbolize_keys
      end

      def rollback_params
        params.require(:rollback).permit(PERMITTED_PARAMS)
      end
    end
  end
end
