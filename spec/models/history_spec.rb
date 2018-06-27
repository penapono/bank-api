# frozen_string_literal: true

require 'rails_helper'

RSpec.describe History, type: :model do
  subject(:history) { build(:history) }

  describe '#factory' do
    it { is_expected.to be_valid }
    it { expect(build(:history, :invalid)).not_to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to(:origin).class_name('Account') }
    it { is_expected.to belong_to(:destination).class_name('Account') }
    it { is_expected.to belong_to :traceable }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :destination }
    it { is_expected.to validate_presence_of :traceable }
    it { is_expected.to validate_presence_of :traceable_id }
    it { is_expected.to validate_presence_of :traceable_type }
  end
end
