# frozen_string_literal: true

module Api
  module Overrides
    # Restriction in login for fos in web and manager in mobile
    class SessionsController < DeviseTokenAuth::SessionsController
      def create
        super
      end
    end
  end
end
