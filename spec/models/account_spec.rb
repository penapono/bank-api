require 'rails_helper'

RSpec.describe Account, type: :model do
  subject(:account) { build(:account) }

  describe '#factory' do
    it { is_expected.to be_valid }
    it { expect(build(:account, :invalid)).not_to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :accountable }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :created_at }
    it { is_expected.to validate_presence_of :accountable_id }
    it { is_expected.to validate_presence_of :accountable_type }
  end
end
