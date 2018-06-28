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

  describe "#show" do
    before { get :show, params: { id: legal_person.id } }

    it "returns legal_persons JSON" do
      body = JSON(response.body)
      expect(body).to include(
        "id" => legal_person.id,
        "social_name" => legal_person.social_name,
        "fantasy_name" => legal_person.fantasy_name,
        "cnpj" => legal_person.cnpj
      )
    end

    it "responds ok" do
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    context "with valid attributes" do
      let(:new_document) { CNPJ.generate }
      before { patch :update, params: { id: legal_person.id, legal_person: { cnpj: new_document } } }

      it "updates legal_person" do
        legal_person.reload
        expect(legal_person.cnpj).to eq new_document
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: legal_person.id, legal_person: { cnpj: nil, social_name: "" } } }

      it "doesn't updates legal_person" do
        legal_person.reload
        expect(legal_person.social_name).to eq social_name
      end

      it "responds bad_request" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "#destroy" do
    context "with valid attributes" do
      before { delete :destroy, params: { id: legal_person.id } }

      it "deletes legal_person" do
        expect(LegalPerson.where(id: legal_person.id).first).to eq nil
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end
  end
end
