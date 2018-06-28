# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::NaturalPeopleController, type: :controller do
  let!(:document) { CPF.generate }
  let!(:natural_person) { create(:natural_person, cpf: document) }
  let(:name) { natural_person.name }

  describe '#create' do
    let(:attributes) { attributes_for(:natural_person) }

    before do
      post :create, params: { natural_person: attributes }
    end

    it 'returns created' do
      body = JSON(response.body)
      expect(body['name']).to eq attributes[:name]
      expect(body['cpf']).to eq attributes[:cpf]
      expect(response.status).to eq 201
    end
  end

  describe '#show' do
    before { get :show, params: { id: natural_person.id } }

    it 'returns natural_persons JSON' do
      body = JSON(response.body)
      expect(body).to include(
        'id' => natural_person.id,
        'name' => natural_person.name,
        'cpf' => natural_person.cpf,
        'birth' => natural_person.birth.to_s
      )
    end

    it 'responds ok' do
      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      let(:new_document) { CPF.generate }
      before { patch :update, params: { id: natural_person.id, natural_person: { cpf: new_document } } }

      it 'updates natural_person' do
        natural_person.reload
        expect(natural_person.cpf).to eq new_document
      end

      it 'responds ok' do
        expect(response.status).to eq 204
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: natural_person.id, natural_person: { cpf: nil, name: '' } } }

      it 'does not updates natural_person' do
        natural_person.reload
        expect(natural_person.name).to eq name
      end

      it 'responds bad_request' do
        expect(response.status).to eq 422
      end
    end
  end

  describe '#destroy' do
    context 'with valid attributes' do
      before { delete :destroy, params: { id: natural_person.id } }

      it 'deletes natural_person' do
        expect(NaturalPerson.where(id: natural_person.id).first).to eq nil
      end

      it 'responds ok' do
        expect(response.status).to eq 204
      end
    end
  end
end
