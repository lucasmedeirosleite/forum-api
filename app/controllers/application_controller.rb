# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  self.responder = ApplicationResponder

  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end
end
