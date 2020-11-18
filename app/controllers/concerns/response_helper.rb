# frozen_string_literal: true

module ResponseHelper
  ##
  # each_serializer is an optional paramter if you want to use custom serializer
  #
  def render_success(status:, data: nil, message: nil, serializer: nil, requested_by: 'vue')
    serializer = "#{data.class.name}Serializer" if serializer.nil?
    serialized_data = begin
                        serializer.constantize.new(data, requested_by: requested_by).as_json
                      rescue StandardError => e
                        Rails.logger.error e
                        data
                      end

    render json: { data: serialized_data, message: message || I18n.t("response.#{status}") }.to_json, status: status
  end

  def render_error(status:, errors: nil, message: nil, description: nil)
    render json: { errors: errors, message: message, description: description }.to_json, status: status
  end

  def render_all(datas:, each_serializer: nil, root: 'data', requested_by: 'vue', response_all: false, meta_data: {}, message: nil)
    return render json: { data: datas, message: message }, meta: meta_data if datas.blank?

    response_datas = response_all ? datas : paginate(datas)
    response_hash = { json: response_datas, each_serializer: each_serializer || "#{datas.model.name}Serializer".constantize, root: root, requested_by: requested_by, meta: meta_data, status: 200 }

    render(response_hash)
  end
end