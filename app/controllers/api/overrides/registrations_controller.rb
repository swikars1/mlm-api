# frozen_string_literal: true

class Api::Overrides::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :authenticate_api_user!

end
