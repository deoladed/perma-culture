# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :messenger

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      '213.215.60.202'
    else 
      request.remote_ip
    end
  end

  protected

  def messenger
  	session[:conversations] ||= []
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :address])
  end

  def after_sign_in_path_for(resource)
    posts_path
  end
end