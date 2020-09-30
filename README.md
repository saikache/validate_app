Ruby - 2.5.3
Rails - 5.2.3

Employee class perform all the validations
Employee controller accept the form inputs and display the outputs
Test cases available in spec/models/employee_spec.rb 


### Requirement:

Create an application that validates ID codes of company employees: John Does looks as follows: DOJO202002196.

Here's how the ID code is derived:
  DO: First 2 characters of the employee's last name.
  JO: First 2 characters of the employee's first name.
  2020: Full year of joining.
  02: 2 digit representation of the month of joining.
  19: Indicates that this is the 19th employee who joined in Feb 2020.
      This will have at least 2 digits, starting with 01, 02, and so on.
  6: The last digit is a verification digit which is computed as follows:
      Take the numeric part of the ID code (without the verification digit).
      Sum all digits in odd positions. Say this is O.
      Sum all digits in even positions. Say this is E.
      Difference between O & E. Say this is V.
      If V is negative, ignore the sign, e.g., -6 is treated as 6. Say this is V.
      If V is greater than 9, divide it by 10 and take the reminder. Say this is V.
      V is the verification code.

An ID code is considered valid if:
  The first 4 characters of the card are correct, i.e. DOJO.
  The verification digit is correct, i.e. 6.

Task:
  Write a rails app that:
    - Allows a user to enter their first name, last name and ID code in a form.
    - It does not create any record, only validates the ID code and returns it's result
    - Write relevant tests.
