class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, PATCH, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def simplecall
    if request.xhr?
      render :json => {
        :simplecall => "simplecall ok!"
      }
    end

    render :json => {
      :simplecall => "simplecall ok!"
    }
  end

end
