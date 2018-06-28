# frozen_string_literal: true

module Api
  module V1
    class ContributionsController < ApplicationController
      PERMITTED_PARAMS = %i[
        uid
        ammount
        account_id
      ].freeze

      # exposes
      expose(:contributions) { Contribution.all }
      expose(:contribution, attributes: :contribution_attributes)

      # GET /contributions
      def index
        json_response(contributions)
      end

      # POST /contributions
      def create
        contribution = CreateContribution.new.create(hash_params)
        json_response(contribution, :created)
      rescue StandardError => error
        json_response(error.message, :unprocessable_entity)
      end

      # GET /contributions/:id
      def show
        json_response(contribution)
      end

      # PUT /contributions/:id
      def update
        return head :no_content if contribution.update(contribution_params)
        json_response(contribution.errors.full_messages, :unprocessable_entity)
      end

      # DELETE /contributions/:id
      def destroy
        contribution.destroy
        head :no_content
      end

      private

      def hash_params
        contribution_params.to_h.symbolize_keys
      end

      def contribution_params
        params.require(:contribution).permit(PERMITTED_PARAMS)
      end
    end
  end
end
