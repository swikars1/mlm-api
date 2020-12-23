# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  self.abstract_class = true
  default_scope { order(updated_at: :desc) }

  def image_url(avatar)
    return unless avatar&.attached?

    final_url = "#{app_setting['host_domain']}#{rails_blob_path(avatar, only_path: true)}"
    final_url
  end

  def image_list_url(image_list)
    image_list.map do |f|
      "#{app_setting['host_domain']}#{rails_blob_path(f, only_path: true)}"
    end
  end

  def app_setting
    YAML.safe_load(File.open(Rails.root.join('config', 'app.yml')))[Rails.env]
  end
end
