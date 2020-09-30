Rails.application.routes.draw do
  get 'employee/index'

  post '/members' => 'employee#validate_id_code', as: :validate_id_code
  root 'employee#index'
  get '(*any)', to: 'employee#index'
end
