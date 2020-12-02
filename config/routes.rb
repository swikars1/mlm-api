# frozen_string_literal: true

require 'api_constraints'
require 'subdomain_constraints'

Rails.application.routes.draw do

  def api_version(version, default, &routes)
    api_constraint = ApiConstraints.new(version: version, default: default)
    scope module: "v#{version}", constraints: api_constraint, &routes
  end


  namespace :api, default: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth',
                                        controllers: {
                                          registrations: 'api/overrides/registrations',
                                          sessions: 'api/overrides/sessions'
                                        }
      resources :customers do
        member do
          get 'clients'
          get 'profits'
          get 'payments'
          get 'my_profits'
          post 'add_payment'
          post 'upload_bill'
        end
      end

      resources :retailers do
        member do
          get 'payments'
          post 'upload_image'
          get 'products'
        end
      end

      resources :retailer_types
      resources :categories do
        member do
          get 'products'
        end
      end

      resources :products do
        member do
          post 'upload_image'
        end
        collection do
          get 'recent'
          get 'featured'
          get 'popular'
        end
      end

      resources :payments

      resources :users do
        member do
          post 'upload_image'
        end
      end
    end
  end
end
