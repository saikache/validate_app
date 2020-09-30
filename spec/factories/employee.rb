# frozen_string_literal: true

FactoryBot.define do
  factory :valid_employee, class: 'Employee' do
    first_name { 'John' }
    last_name { 'Does' }
    id_code { 'DOJO202002196' }
  end

  factory :in_valid_employee, class: 'Employee' do
    first_name { 'J' }
    last_name { 'K' }
    id_code { 'DOJO202' }
  end

end
