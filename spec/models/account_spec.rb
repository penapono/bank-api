# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  subject(:account) { build(:account) }

  describe '#factory' do
    it { is_expected.to be_valid }
    it { expect(build(:account, :invalid)).not_to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :accountable }
    it { is_expected.to belong_to :account }
    it { is_expected.to have_many(:accounts).dependent(:destroy) }
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:status)
        .with(active: 0, blocked: 1, canceled: 2)
    end
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :balance }
    it { is_expected.to validate_presence_of :accountable_id }
    it { is_expected.to validate_presence_of :accountable_type }
  end

  describe '#ancestry' do
    it { is_expected.to respond_to(:root?) }
    it { is_expected.to respond_to(:ancestors?) }
    it { is_expected.to respond_to(:children?) }
  end

  describe 'methods' do
    let!(:ammount) { 10.0 }
    let!(:account_to_move) { create(:account, balance: ammount) }
    let!(:expected_after_debit) { 0 }
    let!(:expected_after_credit) { 20.0 }

    describe 'debit' do
      it 'decreases balance' do
        account_to_move.debit(ammount)
        expect(account_to_move.balance).to eq(expected_after_debit)
      end
    end

    describe 'credit' do
      it 'increases balance' do
        account_to_move.credit(ammount)
        expect(account_to_move.balance).to eq(expected_after_credit)
      end
    end
  end
end
