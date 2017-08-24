class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  load_and_authorize_resource
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => I18n.t('messages.authorization')
  end
end
