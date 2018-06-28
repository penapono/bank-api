# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::HistoriesController, type: :controller do
  let!(:histories_list) { create_list(:history, 3) }

  describe '#index' do
    before { get :index }

    context 'histories' do
      it 'returns all' do
        body = JSON(response.body)
        expect(body).not_to be_empty
      end
    end
  end
end
