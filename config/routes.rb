Rails.application.routes.draw do
  resources :job_applicants
  resources :jobs
  resources :applicants
  resources :employers, param: :name
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
