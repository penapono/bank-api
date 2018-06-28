# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApplicationController
      PERMITTED_PARAMS = %i[
        name
        accountable_id
        accountable_type
        account_id
        status
        balance
        account
      ].freeze

      # exposes
      expose(:accounts) { Account.all }
      expose(:account, attributes: :account_attributes)

      # GET /legal_people
      def index
        json_response(account)
      end

      # POST /legal_people
      def create
        account = CreateAccount.new.create(hash_params)
        json_response(account, :created)
      rescue StandardError => error
        json_response(error.message, :unprocessable_entity)
      end

      # GET /legal_people/:id
      def show
        json_response(account)
      end

      # PUT /legal_people/:id
      def update
        return head :no_content if account.update(account_params)
        json_response(account.errors.full_messages, :unprocessable_entity)
      end

      # DELETE /legal_people/:id
      def destroy
        account.destroy
        head :no_content
      end

      private

      def hash_params
        account_params.to_h.symbolize_keys
      end

      def account_params
        params.require(:account).permit(PERMITTED_PARAMS)
      end
    end
  end
end
