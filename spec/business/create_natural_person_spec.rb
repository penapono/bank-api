# frozen_string_literal: true

RSpec.describe CreateNaturalPerson do
  describe "#create" do
    context '#valid params' do
      let(:params) do
        {
          cpf: CPF.generate,
          name: "Natural Person",
          birth: Date.today - 18.years
        }
      end
      subject(:business) { CreateNaturalPerson.create(params) }

      it "creates a natural person" do
        expect { business }.to change { NaturalPerson.count }.by 1
      end
    end

    context '#invalid params' do
      let(:params) do
        {
          cpf: nil,
          name: nil,
          birth: nil
        }
      end
      subject(:business) { CreateNaturalPerson.create(params) }

      it "doesn't create a natural person" do
        expect { business }.to raise(StandardError)
      end
    end
  end
end
