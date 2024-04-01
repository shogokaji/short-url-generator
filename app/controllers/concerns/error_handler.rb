module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render404
  end

  def render404
    error = Exceptions::NotFound.new
    render_api_exception(error)
  end

  def render_api_exception(e)
    render json: e.to_json, status: e.status
  end
end