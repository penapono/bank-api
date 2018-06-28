# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::AccountsController, type: :controller do
  let!(:balance) { 999.9 }
  let!(:account) { create(:account, balance: balance) }
  let(:name) { account.name }

  describe "#create" do
    let(:attributes) { attributes_for(:account) }

    before do
      post :create, params: { account: attributes }
    end

    it "returns created" do
      body = JSON(response.body)
      expect(body["name"]).to eq attributes[:name]
      expect(body["accountable_id"]).to eq attributes[:accountable_id]
      expect(body["accountable_type"]).to eq attributes[:accountable_type].to_s
      expect(body["account_id"]).to eq attributes[:account_id]
      expect(body["status"]).to eq attributes[:status].to_s
      expect(body["balance"]).to eq attributes[:balance]
      expect(body["account"]).to eq attributes[:account]
      expect(response.status).to eq 201
    end
  end

  describe "#show" do
    before { get :show, params: { id: account.id } }

    it "returns accounts JSON" do
      body = JSON(response.body)
      expect(body).to include(
        "id" => account.id,
        "name" => account.name,
        "balance" => account.balance
      )
    end

    it "responds ok" do
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    context "with valid attributes" do
      let(:new_balance) { 1234.0 }
      before { patch :update, params: { id: account.id, account: { balance: new_balance } } }

      it "updates account" do
        account.reload
        expect(account.balance).to eq new_balance
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: account.id, account: { balance: nil, name: nil } } }

      it "doesn't updates account" do
        account.reload
        expect(account.name).to eq name
      end

      it "responds bad_request" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "#destroy" do
    context "with valid attributes" do
      before { delete :destroy, params: { id: account.id } }

      it "deletes account" do
        expect(LegalPerson.where(id: account.id).first).to eq nil
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end
  end
end
