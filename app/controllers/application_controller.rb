class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to '/', :alert => I18n.t('messages.authorization')
  end
end
