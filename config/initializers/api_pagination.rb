# frozen_string_literal: true

ApiPagination.configure do |config|
  # If you have more than one gem included, you can choose a paginator.
  config.paginator = :kaminari # or :will_paginate
  config.total_header = 'total'

  # By default, this is set to 'Per-Page'
  config.per_page_header = 'per_page'

  # Optional: set this to add a header with the current page number.
  config.page_header = 'page'
  # Optional: what parameter should be used to set the page option
  config.page_param = :page

  # Optional: what parameter should be used to set the per page option
  config.per_page_param = :per_page
end
