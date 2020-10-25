# frozen_string_literal: true

require 'api_constraints'
require 'subdomain_constraints'

Rails.application.routes.draw do

  def api_version(version, default, &routes)
    api_constraint = ApiConstraints.new(version: version, default: default)
    scope module: "v#{version}", constraints: api_constraint, &routes
  end
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
                     controllers: { sessions: 'sessions', registrations: 'registrations' }

  namespace :api, default: { format: :json } do
    api_version(1, true) do

      resources :customers do
        member do
          get 'clients'
          get 'profits'
          get 'payments'
          post 'add_payment'
        end
      end

      resources :retailers do
        member do
          get 'payments'
          post 'upload_image'
        end
      end

      resources :retailer_types
      resources :categories

      resources :products do
        member do
          post 'upload_image'
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
