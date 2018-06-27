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
    it { is_expected.to validate_presence_of :created_at }
    it { is_expected.to validate_presence_of :accountable_id }
    it { is_expected.to validate_presence_of :accountable_type }
  end
end
