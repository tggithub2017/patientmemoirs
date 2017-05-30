class SetssionsController < ApplicationController
  def create
    fuser = Fuser.from_omniauth(env["omniauth.auth"])
    session[:fuser_id] = fuser.id
    redirect_to root_path
  end

  def destroy
    session[:fuser_id] = nil
    redirect_to root_path
  end
end
