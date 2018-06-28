# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::NaturalPeopleController, type: :controller do
  let!(:document) { CPF.generate }
  let!(:natural_person) { create(:natural_person, cpf: document) }
  let(:name) { natural_person.name }

  describe "#create" do
    let(:attributes) { attributes_for(:natural_person) }

    before do
      post :create, params: { natural_person: attributes }
    end

    it "returns created" do
      body = JSON(response.body)
      expect(body["name"]).to eq attributes[:name]
      expect(body["cpf"]).to eq attributes[:cpf]
      expect(response.status).to eq 201
    end
  end
end
