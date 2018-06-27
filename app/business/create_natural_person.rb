# frozen_string_literal: true

class CreateNaturalPerson
  def create(cpf:, name:, birth:)
    natural_person = NaturalPerson.new(cpf: cpf, name: name, birth: birth)
    natural_person.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError.new(error.message)
  end
end
