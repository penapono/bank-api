# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateHistory do
  describe "#create" do
    subject(:business) { CreateHistory.new }
    let(:origin_account) { create(:account) }
    let(:destination_account) { create(:account) }
    let(:transfer) { create(:transfer) }
    let(:contribution) { create(:contribution) }

    context '#valid params' do
      context 'transfer' do
        let(:params) do
          {
            origin_id: origin_account.id,
            destination_id: destination_account.id,
            uid: nil,
            traceable_id: transfer.id,
            traceable_type: transfer.class
          }
        end

        it "traces" do
          expect { business.create(params) }.to change { History.count }.by 1
        end
      end

      context 'contribution' do
        let(:params) do
          {
            origin_id: nil,
            destination_id: contribution.account.id,
            uid: contribution.uid,
            traceable_id: contribution.id,
            traceable_type: contribution.class
          }
        end

        it "traces" do
          expect { business.create(params) }.to change { History.count }.by 1
        end
      end
    end

    context '#invalid params' do
      context 'missing params' do
        let(:params) do
          {
            origin_id: nil,
            destination_id: nil,
            uid: nil,
            traceable_id: nil,
            traceable_type: nil
          }
        end

        it "doesn't trace" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end
    end
  end
end
