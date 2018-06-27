# frozen_string_literal: true

class CreateNaturalPerson
  def create(cpf:, name:, birth:)
    object =
      NaturalPerson.new(
        cpf: cpf, name: name, birth: birth
      )
    object.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end
end