Rails.application.routes.draw do
  resources :job_applicants
  resources :jobs
  resources :applicants, param: :name
   post '/auth', to: 'auth#create'
   get '/auth', to: 'auth#show'
  
  
  resources :employers, param: :name




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
