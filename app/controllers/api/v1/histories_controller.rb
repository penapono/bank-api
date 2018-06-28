# frozen_string_literal: true

module Api
  module V1
    class HistoriesController < ApplicationController
      # exposes
      expose(:histories) { History.all }

      # GET /histories
      def index
        render json: histories
      end
    end
  end
end
