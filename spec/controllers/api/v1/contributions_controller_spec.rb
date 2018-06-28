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

  describe "#show" do
    before { get :show, params: { id: contribution.id } }

    it "returns contributions JSON" do
      body = JSON(response.body)
      expect(body).to include(
        "id" => contribution.id,
        "uid" => contribution.uid,
        "ammount" => contribution.ammount
      )
    end

    it "responds ok" do
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    context "with valid attributes" do
      let(:new_uid) { "A1WSX" }
      before { patch :update, params: { id: contribution.id, contribution: { uid: new_uid } } }

      it "updates contribution" do
        contribution.reload
        expect(contribution.uid).to eq new_uid
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: contribution.id, contribution: { ammount: nil, uid: nil } } }

      it "doesn't updates contribution" do
        contribution.reload
        expect(contribution.ammount).to eq ammount
      end

      it "responds bad_request" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "#destroy" do
    context "with valid attributes" do
      before { delete :destroy, params: { id: contribution.id } }

      it "deletes contribution" do
        expect(LegalPerson.where(id: contribution.id).first).to eq nil
      end

      it "responds ok" do
        expect(response.status).to eq 204
      end
    end
  end
end
