Rails.application.routes.draw do
  resources :job_applicants
  resources :jobs
  resources :applicants, param: :name
  resources :employers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
