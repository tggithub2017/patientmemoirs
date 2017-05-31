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

        vrdinfo = params[:playerinfo]

        parsed_json = ActiveSupport::JSON.decode(vrdinfo)

        if PatientProfile.exists?('nhs_number': parsed_json['nhs'])
            vrdconnect = PatientVrd.new()
            vrdconnect.patient_profile_id = PatientProfile.find_by('nhs_number': parsed_json['nhs']).id
            vrdconnect.dates = parsed_json['date']
            vrdconnect.location = parsed_json['location']
            vrdconnect.o2level = parsed_json['o2level']
            vrdconnect.heartrate = parsed_json['heartrate']
            vrdconnect.headposition = parsed_json['headposition']
            vrdconnect.headrotation = parsed_json['headrotation']
            vrdconnect.save
        end

        # tmpAut = Authcon.find(1)
        # if tmpAut.valid_password?("sdfsdf1")
        #         test = "OK!"
        # else
        #         test = "Wrong!"
        # end

        render :json => {
                            :simplecall => parsed_json['nhs']
                        }
    end
end