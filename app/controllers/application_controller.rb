# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
        
  include ResponseHelper

  def request_agent
    request.env['HTTP_APPTYPE'] == 'mobile' ? 'mobile' : 'vue'
  end

end
