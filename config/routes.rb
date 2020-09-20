# frozen_string_literal: true

require 'api_constraints'
require 'subdomain_constraints'

Rails.application.routes.draw do

  def api_version(version, default, &routes)
    api_constraint = ApiConstraints.new(version: version, default: default)
    scope module: "v#{version}", constraints: api_constraint, &routes
  end

  namespace :api, default: { format: :json } do
    api_version(1, true) do
      devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
                         controllers: { sessions: 'sessions', registrations: 'registrations' }

      resources :customers
      resources :retailers
      resources :products
    end
  end
end
