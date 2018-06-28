# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::RollbacksController, type: :controller do
  let(:ammount) { 10.0 }
  let(:origin) { create(:account, balance: 10_000.0) }
  let(:destination) { create(:account, balance: 10_000.0) }
  let(:transfer) do
    create(:transfer, origin_id: origin.id, destination_id: destination.id, ammount: ammount)
  end

  describe "#create" do
    before do
      post :create, params: { rollback: { transfer_id: transfer.id } }
    end

    it "returns created" do
      expect(response.status).to eq 201
    end
  end
end
