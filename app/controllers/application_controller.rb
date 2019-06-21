class ApplicationController < ActionController::Base
  rescue_from Exception,                        with: :render_500
  rescue_from ActiveRecord::RecordNotFound,     with: :render_404
  rescue_from ActionController::RoutingError,   with: :render_404

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e

    if request.format.to_sym == :json
      render json: { error: "404 error" }, status: :not_found
    else
      render "errors/error_404", status: :not_found
    end
  end

  def render_500(e = nil)
    logger.error "Rendering 500 with exception: #{e.message}" if e
    respond_to do |format|
      format.html { render "errors/error_500", status: :internal_server_error }
      format.all { redirect_to controller: "application" , action: "render_404" }
    end
  end
end
