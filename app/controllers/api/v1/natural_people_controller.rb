# frozen_string_literal: true

module Api
  module V1
    class NaturalPeopleController < ApplicationController
      PERMITTED_PARAMS = %i[
        cpf
        name
        birth
      ].freeze

      # exposes
      expose(:natural_people) { NaturalPeople.all }
      expose(:natural_person, attributes: :natural_person_attributes)

      # GET /natural_people
      def index
        json_response(natural_person)
      end

      # POST /natural_people
      def create
        natural_person = CreateNaturalPerson.new.create(hash_params)
        json_response(natural_person, :created)
      rescue StandardError => error
        json_response(error.message, :unprocessable_entity)
      end

      # GET /natural_people/:id
      def show
        json_response(natural_person)
      end

      # PUT /natural_people/:id
      def update
        return head :no_content if natural_person.update(natural_person_params)
        json_response(natural_person.errors.full_messages, :unprocessable_entity)
      end

      # DELETE /natural_people/:id
      def destroy
        natural_person.destroy
        head :no_content
      end

      private

      def hash_params
        natural_person_params.to_h.symbolize_keys
      end

      def natural_person_params
        params.require(:natural_person).permit(PERMITTED_PARAMS)
      end
    end
  end
end
