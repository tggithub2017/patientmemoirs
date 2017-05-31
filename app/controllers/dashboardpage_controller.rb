class DashboardpageController < ApplicationController
  
  layout false
  
  # before_action :must_login, only: [:show]

  def index
  end
  
  def insert
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.account_id = current_authcon.id;

    tmp_image_name = (current_authcon.id).to_s + (Time.now.strftime("%d%m%Y%H%M%S")).to_s

    if @blog_post.image[0] == 'd'
      image_name = tmp_image_name + 1.to_s
      out_file = File.new("savedimages/" + image_name, "w")
      out_file.puts(@blog_post.image)
      out_file.close
      @blog_post.image = image_name
    end

    if @blog_post.image1[0] == 'd'
      image_name = tmp_image_name + 2.to_s
      out_file = File.new("savedimages/" + image_name, "w")
      out_file.puts(@blog_post.image1)
      out_file.close
      @blog_post.image1 = image_name
    end

    if @blog_post.image2[0] == 'd'
      image_name = tmp_image_name + 3.to_s
      out_file = File.new("savedimages/" + image_name, "w")
      out_file.puts(@blog_post.image2)
      out_file.close
      @blog_post.image2 = image_name
    end

    @blog_post.save
    
    redirect_to dashboardpage_blog_post_path
  end

  def staffprofileinsert
    #staff profile setup
    if params[:staff_profile][:occupation] == "Admin"
      if params[:staff_profile][:detail] != "I am the admin"
        params[:staff_profile][:occupation] = "Staff"
      end
    end
    if params[:staff_profile][:profile_type] == ".patient_summary"
      tmpProfileID = 0
      if StaffProfile.count != 0 && StaffProfile.exists?('authcons_id': current_authcon.id)
        tmpProfileID = StaffProfile.find_by('authcons_id': current_authcon.id).id
        @staff_destroy_profile = StaffProfile.find_by('authcons_id': current_authcon.id)
        @staff_destroy_profile.destroy
      end

      @staff_profile = StaffProfile.new(staff_profile_params)
      @staff_profile.authcons_id = current_authcon.id
      @staff_profile.email = current_authcon.email
      @staff_profile.nhs_number = params[:staff_profile][:nhs_number1] + params[:staff_profile][:nhs_number2] + params[:staff_profile][:nhs_number3]

      tmp_image_name = (current_authcon.id).to_s + (Time.now.strftime("%d%m%Y%H%M%S")).to_s

      if @staff_profile.image[0] == 'd'
        image_name = tmp_image_name + 1.to_s
        out_file = File.new("savedimages/" + image_name, "w")
        out_file.puts(@staff_profile.image)
        out_file.close
        @staff_profile.image = image_name
      end

      @staff_profile.save
      
      # update all history id after profile updating
      if tmpProfileID.to_i
        tmpChange = Message.where('staff_profile_id = ' + tmpProfileID.to_s)
        tmpChange.update_all "staff_profile_id = " + StaffProfile.find_by('authcons_id': current_authcon.id).id.to_s
      end
    #patient profile setup by staff
    else
      tmpProfileID = 0
      tmpType = 0
      current_authcon_patient_id = params[:staff_profile][:authcons_id].to_i

      if params[:staff_profile][:usertype].include? "general"
        if PatientProfile.count != 0 && PatientProfile.exists?('authcons_id': current_authcon_patient_id)
          tmpProfileID = PatientProfile.find_by('authcons_id': current_authcon_patient_id).id
          @patient_destroy_profile = PatientProfile.find_by('authcons_id': current_authcon_patient_id)
          @patient_destroy_profile.destroy
          tmpType = 1
        end
        @patient_profile = PatientProfile.new(staff_profile_params)
        @patient_profile.lead_clinician = StaffProfile.find_by('authcons_id': current_authcon.id).first_name.to_s + ' ' + StaffProfile.find_by('authcons_id': current_authcon.id).last_name.to_s
        @patient_profile.authcons_id = current_authcon_patient_id
      else
        if PatientProfile.count != 0 && PatientProfile.exists?('fusers_id': current_authcon_patient_id)
          tmpProfileID = PatientProfile.find_by('fusers_id': current_authcon_patient_id).id
          @patient_destroy_profile = PatientProfile.find_by('fusers_id': current_authcon_patient_id)
          @patient_destroy_profile.destroy
          tmpType = 2
        end
        @patient_profile = PatientProfile.new(staff_profile_params)
        @patient_profile.lead_clinician = StaffProfile.find_by('authcons_id': current_authcon.id).first_name.to_s + ' ' + StaffProfile.find_by('authcons_id': current_authcon.id).last_name.to_s
        @patient_profile.fusers_id = current_authcon_patient_id      
      end

      @patient_profile.email = params[:staff_profile][:email]
      @patient_profile.nhs_number = params[:staff_profile][:nhs_number1] + params[:staff_profile][:nhs_number2] + params[:staff_profile][:nhs_number3]
      @patient_profile.allowed = 1

      tmp_image_name = (current_authcon.id).to_s + (Time.now.strftime("%d%m%Y%H%M%S")).to_s

      if @patient_profile.image[0] == 'd'
        image_name = tmp_image_name + 1.to_s
        out_file = File.new("savedimages/" + image_name, "w")
        out_file.puts(@patient_profile.image)
        out_file.close
        @patient_profile.image = image_name
      end

      @patient_profile.save

      # update all history id after profile updating
      if tmpProfileID.to_i
        tmpChange = Message.where('patient_profile_id = ' + tmpProfileID.to_s)
        tmpChange1 = Message.where('send_to = ' + tmpProfileID.to_s)
        tmpChange2 = PatientVrd.where('patient_profile_id = ' + tmpProfileID.to_s)
        tmpChange3 = RequestQn.where('patient_profile_id = ' + tmpProfileID.to_s)
        if tmpType == 1
          tmpChange.update_all "patient_profile_id = " + PatientProfile.find_by('authcons_id': current_authcon_patient_id).id.to_s
          tmpChange1.update_all "send_to = " + PatientProfile.find_by('authcons_id': current_authcon_patient_id).id.to_s
          tmpChange2.update_all "patient_profile_id = " + PatientProfile.find_by('authcons_id': current_authcon_patient_id).id.to_s
          tmpChange3.update_all "patient_profile_id = " + PatientProfile.find_by('authcons_id': current_authcon_patient_id).id.to_s
        else
          tmpChange.update_all "patient_profile_id = " + PatientProfile.find_by('fusers_id': current_authcon_patient_id).id.to_s
          tmpChange1.update_all "send_to = " + PatientProfile.find_by('authcons_id': current_authcon_patient_id).id.to_s
          tmpChange2.update_all "patient_profile_id = " + PatientProfile.find_by('fusers_id': current_authcon_patient_id).id.to_s
          tmpChange3.update_all "patient_profile_id = " + PatientProfile.find_by('fusers_id': current_authcon_patient_id).id.to_s
        end
      end
    end

    redirect_to dashboardpage_profilestaff_path
  end

  def patientprofileinsert
    #general patient profile request
    if current_authcon
      if PatientProfile.count != 0 && PatientProfile.exists?('authcons_id': current_authcon.id)
        @patient_destroy_profile = PatientProfile.find_by('authcons_id': current_authcon.id)
        @patient_destroy_profile.destroy
      end

      @patient_profile = PatientProfile.new(patient_profile_params)
      @patient_profile.authcons_id = current_authcon.id
      @patient_profile.email = current_authcon.email
      @patient_profile.allowed = 0
      @patient_profile.occupation = "Patient"
      @patient_profile.nhs_number = params[:patient_profile][:nhs_number1] + params[:patient_profile][:nhs_number2] + params[:patient_profile][:nhs_number3]

      tmp_image_name = (current_authcon.id).to_s + (Time.now.strftime("%d%m%Y%H%M%S")).to_s

      if @patient_profile.image[0] == 'd'
        image_name = tmp_image_name + 1.to_s
        out_file = File.new("savedimages/" + image_name, "w")
        out_file.puts(@patient_profile.image)
        out_file.close
        @patient_profile.image = image_name
      end
    #facebook patient proifle request
    else
      if PatientProfile.count != 0 && PatientProfile.exists?('fusers_id': session[:fuser_id])
        @patient_destroy_profile = PatientProfile.find_by('fusers_id': session[:fuser_id])
        @patient_destroy_profile.destroy
      end

      @patient_profile = PatientProfile.new(patient_profile_params)
      @patient_profile.fusers_id = session[:fuser_id]
      @patient_profile.allowed = 0
      @patient_profile.occupation = "Patient"
      @patient_profile.nhs_number = params[:patient_profile][:nhs_number1] + params[:patient_profile][:nhs_number2] + params[:patient_profile][:nhs_number3]

      tmp_image_name = (session[:fuser_id]).to_s + (Time.now.strftime("%d%m%Y%H%M%S")).to_s

      if @patient_profile.image[0] == 'd'
        image_name = tmp_image_name + 1.to_s
        out_file = File.new("savedimages/" + image_name, "w")
        out_file.puts(@patient_profile.image)
        out_file.close
        @patient_profile.image = image_name
      end      
    end

    @patient_profile.save

    redirect_to dashboardpage_profilepatient_path
  end

  #questionnaire request
  def qnrequestinsert
    @qn_request = RequestQn.new()
    @qn_request.q_type = params[:qn_request][:qntype]
    @qn_request.patient_profile_id = params[:qn_request][:id]
    @qn_request.q1 = params[:qn_request][:q1]
    @qn_request.q2 = params[:qn_request][:q2]
    @qn_request.q3 = params[:qn_request][:q3]
    @qn_request.q4 = params[:qn_request][:q4]
    @qn_request.q5 = params[:qn_request][:q5]
    @qn_request.q6 = params[:qn_request][:q6]
    @qn_request.q7 = params[:qn_request][:q7]
    if params[:qn_request][:qntype].include? "qn1"
      @qn_request.q8 = params[:qn_request][:q8]
      @qn_request.q9 = params[:qn_request][:q9]
    end
    if params[:qn_request][:qntype].include? "qn2"
      @qn_request.q8 = params[:qn_request][:q8]
      @qn_request.q9 = params[:qn_request][:q9]
      @qn_request.q10 = params[:qn_request][:q10]
      @qn_request.q11 = params[:qn_request][:q11]
      @qn_request.q12 = params[:qn_request][:q12]
      @qn_request.q13 = params[:qn_request][:q13]
    end

    @qn_request.save

    redirect_to dashboardpage_serviceqnsetup_path
  end

  def message
    @message_request = Message.new(message_params)
    if @message_request.content != ''
      if current_authcon 
        if Authcon.find(current_authcon.id).usertype == "Staff"
          cid = StaffProfile.find_by('authcons_id': current_authcon.id).id
          @message_request.staff_profile_id = cid
          @message_request.send_to = params[:message_request][:id].to_i
          @message_request.save
        else
          cid = PatientProfile.find_by('authcons_id': current_authcon.id).id
          @message_request.patient_profile_id = cid
          @message_request.send_to = 0
          @message_request.save
        end
      else
        cid = PatientProfile.find_by('fusers_id': session[:fuser_id]).id
        @message_request.patient_profile_id = cid
        @message_request.send_to = 0
        @message_request.save
      end
    end
  end

  def profileperform
    @key = params[:flag]
    @notsignedu = Message.find_by('content': @key)
    @notsignedu.update('patient_profile_id': -2)
    redirect_to dashboardpage_profilestaff_path
  end

  def specialistspostinsert
    @specialists_post = AdminSpecialist.new(specialists_post_params)
    @specialists_post.staff_profile_id = StaffProfile.find_by('authcons_id': current_authcon.id).id

    tmp_image_name = (current_authcon.id).to_s + (Time.now.strftime("%d%m%Y%H%M%S")).to_s
    if @specialists_post.image[0] == 'd'
      image_name = tmp_image_name + 1.to_s
      out_file = File.new("savedimages/" + image_name, "w")
      out_file.puts(@specialists_post.image)
      out_file.close
      @specialists_post.image = image_name
    end
    
    @specialists_post.save

    redirect_to dashboardpage_specialists_post_path
  end

  def profilepatient
    if current_authcon
      patient_profile_id = PatientProfile.find_by('authcons_id': current_authcon.id)
    else
      patient_profile_id = PatientProfile.find_by('fusers_id': session[:fuser_id])
    end

    if params[:pointer_profile] && params[:pointer_profile][:pointer]
      history_sel = params[:pointer_profile][:pointer]
    end

    tmpvrd = PatientVrd.where('patient_profile_id': patient_profile_id)
    
    if tmpvrd.count > 0
      if params[:pointer_profile] && params[:pointer_profile][:pointer]
        history_sel = params[:pointer_profile][:pointer]
        chartdatafa = PatientVrd.find_by('created_at': history_sel, 'patient_profile_id': patient_profile_id)
      else
        chartdatafa = tmpvrd.last
      end
      
      if chartdatafa.o2level.to_s.length != 0
        tmpo2level = chartdatafa.o2level
        tmpo2level = tmpo2level.split(',')

        o2level = '{
                "chart": {
                    "caption": "Oxygen Level",
                    "xAxisName": "Time Line",
                    "yAxisName": "O2 Level",
                    "showvalues": 0,
                    "theme": "fint",
                    "anchorBgHoverColor": "#7d7d7d",                
                    "anchorBorderHoverThickness" : "10",
                    "anchorHoverRadius":"10",
                    "showAnchors":"0"
                },
                "data": ['

        for i in 0..tmpo2level.count - 1
          if i != tmpo2level.count - 1
            if (i + 1)%10 === 0
              o2level = o2level + '{"label":"' + (i + 1).to_s + '", "value":' + tmpo2level[i] + '},'
            else
              o2level = o2level + '{"value":' + tmpo2level[i] + '},'
            end
          else
            o2level = o2level + '{"label": "' + (i + 1).to_s + '", "value":' + tmpo2level[i] + '}]}'
          end
        end
      else
        o2level = '{
                "chart": {
                    "caption": "Oxygen Level",
                    "xAxisName": "Time Line",
                    "yAxisName": "O2 Level",
                    "theme": "fint",
                    "anchorBgHoverColor": "#7d7d7d",                
                    "anchorBorderHoverThickness" : "4",
                    "anchorHoverRadius":"7",
                    "showAnchors":"0"
                },
                "data": []}'   
      end

      if chartdatafa.heartrate.to_s.length != 0
        tmpheartrate = chartdatafa.heartrate
        tmpheartrate = tmpheartrate.split(',')

        heartrate = '{
                "chart": {
                    "caption": "Oxygen Level",
                    "xAxisName": "Time Line",
                    "yAxisName": "O2 Level",
                    "showvalues": 0,
                    "theme": "fint",
                    "anchorBgHoverColor": "#7d7d7d",                
                    "anchorBorderHoverThickness" : "10",
                    "anchorHoverRadius":"10",
                    "showAnchors":"0"
                },
                "data": ['

        for i in 0..tmpheartrate.count - 1
          if i != tmpheartrate.count - 1
            if (i + 1)%10 === 0
              heartrate = heartrate + '{"label":"' + (i + 1).to_s + '", "value":' + tmpheartrate[i] + '},'
            else
              heartrate = heartrate + '{"value":' + tmpheartrate[i] + '},'
            end
          else
            heartrate = heartrate + '{"label": "' + (i + 1).to_s + '", "value":' + tmpheartrate[i] + '}]}'
          end
        end
      else
        heartrate = '{
                "chart": {
                    "caption": "Heart Rate",
                    "xAxisName": "Time Line",
                    "yAxisName": "Heart Rate Level",
                    "theme": "fint",
                    "anchorBgHoverColor": "#7d7d7d",                
                    "anchorBorderHoverThickness" : "4",
                    "anchorHoverRadius":"7",
                    "showAnchors":"0"
                },
                "data": []}'   
      end

      if chartdatafa.headposition.to_s.length != 0
        @tmpheadposition = chartdatafa.headposition
        @tmpheadposition = @tmpheadposition.gsub('x','')
        @tmpheadposition = @tmpheadposition.gsub('y',' ')
        @tmpheadposition = @tmpheadposition.gsub('z',' ')
      else
        @tmpheadposition = ""
      end
      
      @tmphistory = tmpvrd
    else
      heartrate = '{
              "chart": {
                  "caption": "Oxygen Level",
                  "xAxisName": "Time Line",
                  "yAxisName": "O2 Level",
                  "theme": "fint",
                  "anchorBgHoverColor": "#7d7d7d",                
                  "anchorBorderHoverThickness" : "4",
                  "anchorHoverRadius":"7",
                  "showAnchors":"0"
              },
              "data": []}'
    end

    @chart = Fusioncharts::Chart.new({
        :height => 400,
        :width => "100%",
        :id => 'chart',
        :type => 'line',
        :renderAt => 'chart-container',
        :dataSource => o2level
    })

    @chartR = Fusioncharts::Chart.new({
        :height => 400,
        :width => "100%",
        :id => 'chart',
        :type => 'line',
        :renderAt => 'chart-containerR',
        :dataSource => heartrate
    })
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :description, :detail, :image, :image1, :image2)
  end

  def staff_profile_params
    params.require(:staff_profile).permit(:image, :first_name, :last_name, :sex, :birthdate, :email, :phone_number, :address, :occupation, :detail)  
  end

  def patient_profile_params
    params.require(:patient_profile).permit(:image, :first_name, :last_name, :sex, :birthdate, :email, :phone_number, :address, :occupation, :detail)  
  end

  def message_params    
    params.require(:message_request).permit(:content)    
  end

  def specialists_post_params
    params.require(:specialists_post).permit(:title, :description, :detail, :image)  
  end
end