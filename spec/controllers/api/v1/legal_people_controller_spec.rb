# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::LegalPeopleController, type: :controller do
  let!(:document) { CNPJ.generate }
  let!(:legal_person) { create(:legal_person, cnpj: document) }
  let(:social_name) { legal_person.social_name }

  describe "#create" do
    let(:attributes) { attributes_for(:legal_person) }

    before do
      post :create, params: { legal_person: attributes }
    end

    it "returns created" do
      body = JSON(response.body)
      expect(body["social_name"]).to eq attributes[:social_name]
      expect(body["fantasy_name"]).to eq attributes[:fantasy_name]
      expect(body["cnpj"]).to eq attributes[:cnpj]
      expect(response.status).to eq 201
    end
  end
end
