Rails.application.routes.draw do
  namespace :api, path: '/', defaults: { format: 'json' } do
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      with_options except: [:new, :edit] do |list_only|
        list_only.resources :bucketlists do
          list_only.resources :items
        end
      end
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  get 'auth/logout', to: 'authentication#logout'

  post 'signup', to: 'users#create'
end
