Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: 'api' do
    namespace :api, path: '/' do
      resources :petpredictor, only: [:index, :create]
    end
  end
  resources :raw_stat
end
