# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transfer, type: :model do
  subject(:transfer) { build(:transfer) }

  describe '#factory' do
    it { is_expected.to be_valid }
    it { expect(build(:transfer, :invalid)).not_to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to(:origin).class_name('Account') }
    it { is_expected.to belong_to(:destination).class_name('Account') }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :origin }
    it { is_expected.to validate_presence_of :destination }
    it { is_expected.to validate_presence_of :ammount }
  end
end
