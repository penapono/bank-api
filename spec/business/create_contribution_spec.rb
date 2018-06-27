# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateContribution do
  describe "#create" do
    subject(:business) { CreateContribution.new }
    let!(:destination_account) { create(:account) }

    context '#valid params' do
      let(:params) do
        {
          uid: "A1B2C3",
          account_id: destination_account.id,
          ammount: 1000.0
        }
      end

      it "transfers" do
        expect { business.create(params) }.to change { Contribution.count }.by 1
      end

      it "leaves trace" do
        expect { business.create(params) }.to change { History.count }.by 1
      end
    end

    context '#invalid params' do
      context 'missing params' do
        let(:params) do
          {
            uid: nil,
            account_id: nil,
            ammount: nil
          }
        end

        it "doesn't contribute" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'non existent account' do
        let(:params) do
          {
            uid: "G7H8I0",
            account_id: Account.last.id + 1,
            ammount: 1000.0
          }
        end

        it "doesn't contribute" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'child account' do
        let(:child_account) { create(:account, :child) }
        let(:params) do
          {
            uid: "D4E5F6",
            account_id: child_account.id,
            ammount: nil
          }
        end

        it "doesn't contribute" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'invalid ammount' do
        let(:params) do
          {
            uid: "J1K2L3",
            account_id: destination_account.id,
            ammount: -10.0
          }
        end

        it "doesn't contribute" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'invalid account status' do
        let(:canceled_account) { create(:account, status: 2) }
        let(:params) do
          {
            uid: "M4N5O6",
            account_id: canceled_account.id,
            ammount: 1000.0
          }
        end

        it "doesn't contribute" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end
    end
  end
end
