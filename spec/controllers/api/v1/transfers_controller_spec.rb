# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::TransfersController, type: :controller do
  let!(:origin_account) { create(:account, balance: 100_000.0) }
  let(:ammount) { 90.0 }
  let!(:base_transfer) { build(:transfer, origin_id: origin_account.id, ammount: ammount) }
  let!(:transfer) { create(:transfer) }

  describe "#create" do
    let(:attributes) { base_transfer.attributes }

    before do
      post :create, params: { transfer: attributes }
    end

    it "returns created" do
      body = JSON(response.body)
      expect(body["ammount"]).to eq base_transfer.ammount
      expect(body["origin_id"]).to eq base_transfer.origin_id
      expect(body["destination_id"]).to eq base_transfer.destination_id
      expect(response.status).to eq 201
    end
  end

  describe "#show" do
    before { get :show, params: { id: transfer.id } }

    it "returns transfers JSON" do
      body = JSON(response.body)
      expect(body).to include(
        "id" => transfer.id,
        "ammount" => transfer.ammount
      )
    end

    it "responds ok" do
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    context "with valid attributes" do
      let(:new_ammount) { 1234.0 }
      before { patch :update, params: { id: transfer.id, transfer: { ammount: new_ammount } } }

      it "updates transfer" do
        transfer.reload
        expect(transfer.ammount).to eq new_ammount
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: transfer.id, transfer: { ammount: nil } } }

      it "doesn't updates transfer" do
        transfer.reload
        expect(transfer.ammount).to eq 1.0
      end

      it "responds bad_request" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "#destroy" do
    context "with valid attributes" do
      before { delete :destroy, params: { id: transfer.id } }

      it "deletes transfer" do
        expect(LegalPerson.where(id: transfer.id).first).to eq nil
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end
  end
end
