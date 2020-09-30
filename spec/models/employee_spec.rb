# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee do
  context 'in-valid' do
    let!(:employee) { FactoryBot.build :in_valid_employee }

    it 'should return false for invalid employee' do
      expect(employee.valid?).to be false
    end

    it 'should return minimum characters validation' do
      employee.valid?
      expect(employee.errors.messages[:first_name]).to eq ['is too short (minimum is 2 characters)']
      expect(employee.errors.messages[:last_name]).to eq ['is too short (minimum is 2 characters)']
      expect(employee.errors.messages[:id_code]).to eq ['is too short (minimum is 13 characters)']
    end

    it 'should return first 4 chars in-validate if first_name, last_name not matches to id_code' do
      employee.valid?
      expect(employee.errors.messages[:first_four_chars]).to eq ['are not valid']
    end

    it 'should return only length validation of id_code, when first_name last_name valid' do
      employee.id_code = 'JODOXXX'
      employee.first_name = 'John'
      employee.last_name = 'Does'
      employee.valid?
      expect(employee.errors.messages[:id_code]).to eq ['is too short (minimum is 13 characters)']
      expect(employee.errors.messages[:first_name]).to eql([])
      expect(employee.errors.messages[:last_name]).to eql([])
    end
  end

  context 'validate' do
    let!(:employee) { FactoryBot.build :valid_employee }
    it 'should not return no errors for valid employee' do
      expect(employee.valid?).to be true
    end

    it 'should not return errors if first 4 characters matches with id_code' do
      employee.id_code = 'DOJOXXXXXXXXX'
      employee.valid?
      expect(employee.errors.messages[:first_four_chars]).to eql([])
    end

    it 'in-validate id_code code with generated id_code' do
      employee.id_code = 'DOJOXXXXXXXXX'
      employee.valid?
      employee.validate_employee_id_code
      expect(employee.errors.messages[:id_code]).to eql(['is not valid'])
    end

    it 'validate id_code code with generated id_code' do
      employee.valid?
      employee.validate_employee_id_code
      expect(employee.errors.messages[:id_code]).to eql([])
    end
  end
end
