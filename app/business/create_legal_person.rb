# frozen_string_literal: true

class CreateLegalPerson
  def create(cnpj:, social_name:, fantasy_name:)
    object =
      LegalPerson.new(
        cnpj: cnpj, social_name: social_name, fantasy_name: fantasy_name
      )
    object.save!
  rescue ActiveRecord::RecordInvalid => error
    raise StandardError, error.message
  end
end
