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

      # GET /accounts
      def index
        json_response(accounts)
      end

      # POST /accounts
      def create
        account = Account.create!(account_params)
        json_response(account, :created)
      end

      # GET /accounts/:id
      def show
        json_response(account)
      end

      # PUT /accounts/:id
      def update
        account.update(account_params)
        head :no_content
      end

      # DELETE /accounts/:id
      def destroy
        account.destroy
        head :no_content
      end

      private

      def account_params
        params.require(:account).permit(PERMITTED_PARAMS)
      end
    end
  end
end
