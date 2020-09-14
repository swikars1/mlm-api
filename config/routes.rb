# frozen_string_literal: true

require 'api_constraints'
require 'subdomain_constraints'

Rails.application.routes.draw do
  namespace :api, default: { format: :json } do
    devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
                       controllers: { sessions: 'sessions', registrations: 'registrations' }
  end
end
