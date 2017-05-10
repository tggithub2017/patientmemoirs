class SessionsController < ApplicationController
  
  layout false

  def new
  end

  def create 
  end

  def destroy 
  end

  def create1
    fuser = Fuser.from_omniauth(env["omniauth.auth"])
    session[:fuser_id] = fuser.id
    redirect_to root_path
  end

  def email
  end

  def destroy1
    session[:fuser_id] = nil
    redirect_to root_path  
  end
end
