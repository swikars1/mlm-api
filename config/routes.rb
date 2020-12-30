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
      get 'search_all' => 'customers#search_all'
      resources :customers do
        member do
          get 'clients'
          get 'profits'
          get 'payments'
          get 'my_profits'
          get 'bills'
          post 'add_payment'
          post 'upload_bill'
          post 'upload_image'
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
        collection do
          get 'mobile'
        end
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
          post 'update_password'
        end
      end

      resources :dashboard do
        collection do
          get 'widgets'
          get 'gender_pie_chart'
          get 'line_chart'
        end
      end
    end
  end
end
