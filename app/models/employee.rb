# frozen_string_literal: true

# To validate a Employee id code
class Employee
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :id_code

  validates_length_of :first_name, minimum: 2
  validates_length_of :last_name, minimum: 2
  validates_length_of :id_code, minimum: 13
  validate :validate_first_four_chars_with_id_code

  # Compare id_code with generated id_code
  def validate_employee_id_code
    return true if generate_id_code == id_code

    errors.add(:id_code, 'is not valid') and return false
  end

  private

  def validate_first_four_chars_with_id_code
    errors.add(:first_four_chars, 'are not valid') unless first_four_chars == id_code.to_s.first(4).upcase
  end

  # Generating id_code with provided conditions
  def generate_id_code
    "#{id_code_with_out_verification_code}#{verification_digit}"
  end

  # To Generate verification Digit with odd even positions of numeric part of ID code
  def verification_digit
    difference_value = odd_positions_sum - even_positions_sum
    result = difference_value.negative? ? -difference_value : difference_value # ignore - sign
    result > 9 ? (result % 10) : result # calulate reminder if difference is greater than 9
  end

  # Sum of digits in even positions
  def even_positions_sum
    numaric_digit_of_id_code.to_s.split('').map(&:to_i).select.with_index { |_, index| index.even? }.sum
  end

  # Sum of digits in odd positions
  def odd_positions_sum
    numaric_digit_of_id_code.to_s.split('').map(&:to_i).select.with_index { |_, index| index.odd? }.sum
  end

  # Pick numaric digit except 4 charecters from first and exclude last verification code
  def numaric_digit_of_id_code
    id_code[4..-2]
  end

  # Example of id_code => DOJO20200219 6
  def id_code_with_out_verification_code
    "#{first_four_chars}#{numaric_digit_of_id_code}"
  end

  # John Does  => DOJO
  def first_four_chars
    first_two_chars = first_name.to_s.first(2).upcase
    last_two_chars  = last_name.to_s.first(2).upcase
    "#{last_two_chars}#{first_two_chars}"
  end
end
