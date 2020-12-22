Rails.application.routes.draw do
  resources :timesheet, only: [:create]
  get '/payroll_report', to: 'payroll_report#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
