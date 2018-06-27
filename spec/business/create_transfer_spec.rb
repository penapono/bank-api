# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateTransfer do
  describe "#create" do
    subject(:business) { CreateTransfer.new }
    let!(:origin_account) { create(:account, balance: 1000.0) }
    let!(:destination_account) { create(:account) }

    context '#valid params' do
      let(:params) do
        {
          origin_id: origin_account.id,
          destination_id: destination_account.id,
          ammount: 1000.0
        }
      end

      it "transfers" do
        expect { business.create(params) }.to change { Transfer.count }.by 1
      end

      it "leaves trace" do
        expect { business.create(params) }.to change { History.count }.by 1
      end
    end

    context '#invalid params' do
      context 'missing params' do
        let(:params) do
          {
            origin_id: nil,
            destination_id: nil,
            ammount: nil
          }
        end

        it "doesn't transfer" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'same account' do
        let(:params) do
          {
            origin_id: origin_account.id,
            destination_id: origin_account.id,
            ammount: 1000.0
          }
        end

        it "doesn't transfer" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'invalid ammount' do
        let(:params) do
          {
            origin_id: origin_account.id,
            destination_id: destination_account.id,
            ammount: -10.0
          }
        end

        it "doesn't transfer" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'not enough balance' do
        let(:poor_account) { create(:account, balance: 0.0) }
        let(:params) do
          {
            origin_id: poor_account.id,
            destination_id: destination_account.id,
            ammount: 1000.0
          }
        end

        it "doesn't transfer" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'invalid account status' do
        let(:canceled_account) { create(:account, status: 2) }
        let(:params) do
          {
            origin_id: canceled_account.id,
            destination_id: destination_account.id,
            ammount: 1000.0
          }
        end

        it "doesn't transfer" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end
    end
  end
end
