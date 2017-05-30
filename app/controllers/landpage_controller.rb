class LandpageController < ApplicationController
  
  layout false

  helper_method :current_fuser, :logged_in?

  def index
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @blog_data = BlogPost.where('id is not null')
  end

  def logged_in?
    @current_user
  end

  protect_from_forgery with: :exception
  helper_method :current_fuser

  def current_fuser
    @current_fuser ||= Fuser.find(session[:fuser_id]) if session[:fuser_id]
  end

  def make_appointment
    @appointment = Message.new()
    @appointment.patient_profile_id = -1
    @appointment.send_to = 0
    @appointment.content = params[:name].to_s + '|' + params[:number].to_s + '|' + params[:email].to_s + '|' + params[:date].to_s + '|' + params[:message].to_s
    @appointment.save
  end

  # protect_from_forgery with: :exception
  # helper_method :current_guser

  # def current_guser
  #   @current_guser ||= Guser.find(session[:guser_id]) if session[:guser_id]
  # end

  # def must_login
  #   if !logged_in?
  #     flash[:danger] = "Please login!"
  #     redirect_to login_path  
  #   end
  # end
  
end
