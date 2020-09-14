# frozen_string_literal: true

class SubdomainConstraint
  def self.matches?(_request)
    # request.subdomain.present? && request.subdomain != 'www'
    true
  end
end
