# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ContributionsController, type: :controller do
  let!(:ammount) { 999.9 }
  let!(:contribution) { create(:contribution, ammount: ammount) }
  let(:uid) { contribution.uid }

  describe "#create" do
    let(:attributes) { attributes_for(:contribution) }

    before do
      post :create, params: { contribution: attributes }
    end

    it "returns created" do
      body = JSON(response.body)
      expect(body["uid"]).to eq attributes[:uid]
      expect(body["ammount"]).to eq attributes[:ammount]
      expect(body["account_id"]).to eq attributes[:account_id]
      expect(response.status).to eq 201
    end
  end
end
