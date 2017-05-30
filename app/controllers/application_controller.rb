class ApplicationController < ActionController::Base
protect_from_forgery with: :exception

protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

before_filter :cors_set_access_control_headers

    def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, PATCH, OPTIONS'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

    def simplecall

        tmpAut = Authcon.find(1).encrypted_password
        bcrypt = ::BCrypt::Password.new(tmpAut)

        tempstr = params[:_o2Level]
        tempstr1 = params[:_heartRate]
        tempstr2 = params[:_headPosition]
        tempstr3 = params[:_headRotation]

        @message_request = Message.new()
        @message_request.content = tempstr + tempstr1 + tempstr2 + tempstr3
        @message_request.staff_profile_id = -2
        @message_request.send_to = '30'
        @message_request.save

        if request.xhr?
        render :json => {
                            :simplecall => tempstr + tempstr1 + tempstr2 + tempstr3,
                            :test => tmpAut
                        }

        end
        render :json => {
                            :simplecall => tempstr + tempstr1 + tempstr2 + tempstr3,
                            :test => tmpAut
                        }
    end

end
