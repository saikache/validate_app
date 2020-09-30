# frozen_string_literal: true

# Handles employee form and validates id_code
class EmployeeController < ApplicationController
  def index
    temporary_parameters = { first_name: 'John', last_name: 'Does', id_code: 'DOJO202002196' }
    @employee = Employee.new(temporary_parameters)
  end

  def validate_id_code
    @employee = Employee.new(employee_params)
    if @employee.valid? && @employee.validate_employee_id_code
      redirect_to root_path, notice: "Valid Code is - #{@employee.id_code}"
    else
      render :index
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :id_code)
  end
end
