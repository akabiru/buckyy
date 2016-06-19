Rails.application.routes.draw do
  namespace :api, path: '/', defaults: { format: 'json' } do
    namespace :v1 do
      with_options except: [:new] do |list_only|
        list_only.resources :bucket_lists do
          list_only.resources :items
        end
      end
    end
  end
end
