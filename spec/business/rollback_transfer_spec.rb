# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RollbackTransfer do
  describe "#rollback" do
    subject(:business) { RollbackTransfer.new }
    let!(:transfer) { create(:transfer) }

    context '#valid params' do
      let(:params) do
        {
          transfer_id: transfer.id
        }
      end

      it "transfers" do
        # provisioning enough limit to rollback transactions
        transfer.destination.credit(1000)
        transfer.origin.credit(1000)
        expect { business.rollback(params) }.to change { Transfer.count }.by 1
      end

      it "leaves trace" do
        # provisioning enough limit to rollback transactions
        transfer.destination.credit(1000)
        transfer.origin.credit(1000)
        expect { business.rollback(params) }.to change { History.count }.by 1
      end
    end

    context '#invalid params' do
      context 'missing params' do
        let(:params) do
          {
            transfer_id: nil
          }
        end

        it "doesn't rollback transfer" do
          expect { business.rollback(params) }.to raise_error(StandardError)
        end
      end
    end
  end
end
