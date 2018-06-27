# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateLegalPerson do
  describe "#create" do
    context '#valid params' do
      let(:params) do
        {
          cnpj: CNPJ.generate,
          social_name: "SOCIAL BANK S.A.",
          fantasy_name: "Hub Card"
        }
      end
      subject(:business) { CreateLegalPerson.new.create(params) }

      it "creates a legal person" do
        expect { business }.to change { LegalPerson.count }.by 1
      end
    end

    context '#invalid params' do
      let(:params) do
        {
          cnpj: nil,
          social_name: nil,
          fantasy_name: nil
        }
      end
      subject(:business) { CreateLegalPerson.new.create(params) }

      it "doesn't create a legal person" do
        expect { business }.to raise_error(StandardError)
      end
    end
  end
end
