class SegssionsController < ApplicationController
  def create
    guser = Guser.from_omniauth(env["omniauth.auth"])
    session[:guser_id] = guser.id
    redirect_to root_path
  end

  def destroy
    session[:guser_id] = nil
    redirect_to root_path
  end
end
