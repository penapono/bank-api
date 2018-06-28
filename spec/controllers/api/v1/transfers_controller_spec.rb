# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::TransfersController, type: :controller do
  let!(:origin_account) { create(:account, balance: 100_000.0) }
  let(:ammount) { 90.0 }
  let!(:base_transfer) { build(:transfer, origin_id: origin_account.id, ammount: ammount) }
  let!(:transfer) { create(:transfer) }
  let!(:transfers_list) { create_list(:transfer, 3) }

  describe '#index' do
    before { get :index }

    context 'transfers' do
      it 'returns all' do
        body = JSON(response.body)
        expect(body).not_to be_empty
      end
    end
  end

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
end
