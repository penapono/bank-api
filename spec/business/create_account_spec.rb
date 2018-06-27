# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateAccount do
  describe "#create" do
    subject(:business) { CreateAccount.new }
    let!(:matrix_account) { create(:account) }
    let!(:natural_person) { create(:natural_person) }
    let!(:legal_person) { create(:legal_person) }

    context '#valid params' do
      context 'matrix' do
        context 'created by natural_person' do
          let(:params) do
            {
              name: "Conta",
              accountable_id: natural_person.id,
              accountable_type: natural_person.class,
              account_id: nil,
              status: :active,
              balance: 0
            }
          end

          it "creates" do
            expect { business.create(params) }.to change { Account.count }.by 1
          end

          it "leaves trace" do
            expect { business.create(params) }.to change { History.count }.by 1
          end
        end

        context 'created by legal_person' do
          let(:params) do
            {
              name: "Conta",
              accountable_id: legal_person.id,
              accountable_type: legal_person.class,
              account_id: nil,
              status: :active,
              balance: 0
            }
          end

          it "creates" do
            expect { business.create(params) }.to change { Account.count }.by 1
          end

          it "leaves trace" do
            expect { business.create(params) }.to change { History.count }.by 1
          end
        end
      end

      context 'child account' do
        context 'created by natural_person' do
          let(:params) do
            {
              name: "Conta",
              accountable_id: natural_person.id,
              accountable_type: natural_person.class,
              account_id: matrix_account.id,
              status: :active,
              balance: 0
            }
          end

          it "creates" do
            expect { business.create(params) }.to change { Account.count }.by 1
          end

          it "leaves trace" do
            expect { business.create(params) }.to change { History.count }.by 1
          end
        end

        context 'created by legal_person' do
          let(:params) do
            {
              name: "Conta",
              accountable_id: legal_person.id,
              accountable_type: legal_person.class,
              account_id: matrix_account.id,
              status: :active,
              balance: 0
            }
          end

          it "creates" do
            expect { business.create(params) }.to change { Account.count }.by 1
          end

          it "leaves trace" do
            expect { business.create(params) }.to change { History.count }.by 1
          end
        end
      end

      context 'invalid balance' do
        let(:params) do
          {
            name: "Conta",
            accountable_id: natural_person.id,
            accountable_type: natural_person.class,
            account_id: nil,
            status: :active,
            balance: -10.0
          }
        end

        it "doesn't create" do
          expect { business.create(params) }.to change { Account.count }.by 1
        end
      end
    end

    context '#invalid params' do
      context 'missing params' do
        let(:params) do
          {
            name: nil,
            accountable_id: nil,
            accountable_type: nil,
            account_id: nil,
            status: nil,
            balance: nil
          }
        end

        it "doesn't create" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end

      context 'invalid person' do
        let(:params) do
          {
            name: "Conta",
            accountable_id: NaturalPerson.last.id + 1,
            accountable_type: 'NaturalPerson',
            account_id: nil,
            status: :active,
            balance: 0
          }
        end

        it "doesn't create" do
          expect { business.create(params) }.to raise_error(StandardError)
        end
      end
    end
  end
end
