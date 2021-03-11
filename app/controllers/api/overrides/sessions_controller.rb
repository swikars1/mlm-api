# frozen_string_literal: true

module Api
  module Overrides
    # Restriction in login for fos in web and manager in mobile
    class SessionsController < DeviseTokenAuth::SessionsController
      def create
        super  { send("#{request_agent}_login") }
      end
      private

      # Allow only login in mobile devices.
      def mobile_login
        raise Exception.new "Admin not allowed here" unless current_api_v1_user.customer?
      end

      # Restrict customer to login in web.
      def vue_login
        raise Exception.new "Customer not allowed to login" if current_api_v1_user.customer?
      end
    end
  end
end
