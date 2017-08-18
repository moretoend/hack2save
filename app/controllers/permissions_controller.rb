class PermissionsController < ApplicationController
  
  before_action :load_permissions, only: :index
  before_action :load_permission, only: [:edit, :update, :destroy]


  def index
  end


  def new
    build_permission
  end


  def create
    build_permission
    save_permission || render(:new, status: :unprocessable_entity)
  end


  def edit
  end


  def update
    build_permission
    save_permission || render(:edit, status: :unprocessable_entity)
  end


  def destroy
    @permission.destroy
    redirect_to institution_permissions_path(@permission.institution.id)
  end


  private


  def save_permission
    redirect_to institution_permissions_path(@permission.institution.id) if @permission.save
  end


  def build_permission
    @permission ||= permission_scope.build
    @permission.attributes = permission_params
  end


  def load_permissions
    @permissions = permission_scope
  end


  def load_permission
    @permission = permission_scope.find(params[:id])
  end


  def permission_params
    return {} unless params[:permission].present?
    params.require(:permission).permit(:id, :user_id, :profile)
  end


  def permission_scope
    Institution.find(params[:institution_id]).permissions
  end

end
