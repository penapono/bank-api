# frozen_string_literal: true

module Api
  module V1
    class LegalPeopleController < ApplicationController
      PERMITTED_PARAMS = %i[
        cnpj
        social_name
        fantasy_name
      ].freeze

      # exposes
      expose(:legal_people) { LegalPerson.all }
      expose(:legal_person, attributes: :legal_person_attributes)

      # GET /legal_people
      def index
        json_response(legal_people)
      end

      # POST /legal_people
      def create
        legal_person = CreateLegalPerson.new.create(hash_params)
        json_response(legal_person, :created)
      rescue StandardError => error
        json_response(error.message, :unprocessable_entity)
      end

      # DELETE /legal_people/:id
      def destroy
        legal_person.destroy
        head :no_content
      end

      private

      def hash_params
        legal_person_params.to_h.symbolize_keys
      end

      def legal_person_params
        params.require(:legal_person).permit(PERMITTED_PARAMS)
      end
    end
  end
end
