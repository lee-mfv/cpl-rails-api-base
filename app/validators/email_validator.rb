class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
      record.errors.add(attribute, :not_an_email, message: "is a valid username")
    end
  end
end
