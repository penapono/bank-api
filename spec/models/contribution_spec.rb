# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contribution, type: :model do
  subject(:contribution) { build(:contribution) }

  describe '#factory' do
    it { is_expected.to be_valid }
    it { expect(build(:contribution, :invalid)).not_to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :account }
    it { is_expected.to have_many(:histories).dependent(:destroy) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :uid }
    it { is_expected.to validate_uniqueness_of(:uid).ignoring_case_sensitivity }
    it { is_expected.to validate_presence_of :account }
    it { is_expected.to validate_presence_of :ammount }
  end
end
