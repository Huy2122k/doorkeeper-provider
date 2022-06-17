# frozen_string_literal: true

class OauthApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @application = current_user.oauth_applications.new
    @applications = current_user.oauth_applications.ordered_by(:created_at)
  end
  def show 
    @application = current_user.oauth_applications.find(params[:id])
  end
  def create
    @application = current_user.oauth_applications.new(application_params)
    
    # binding.pry
    
    if @application.save
      redirect_to oauth_application_url(@application)
    else
      render :index
    end
  end


  def destroy
    if @application.destroy
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications destroy])
    end

    redirect_to oauth_applications_url
  end

  private


    def application_params
      params.require(:doorkeeper_application).permit(:name, :redirect_uri, :scopes, :confidential)
    end
end
