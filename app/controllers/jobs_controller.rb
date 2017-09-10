class JobsController < ApplicationController
  
  before_action :load_jobs, only: :index
  before_action :load_job, only: [:show, :edit, :update, :destroy]


  def index
  end


  def new
    build_job
  end


  def create
    build_job
    save_job || render(:new, status: :unprocessable_entity)
  end


  def show
  end


  def edit
  end


  def update
    build_job
    save_job || render(:edit, status: :unprocessable_entity)
  end


  def destroy
    @job.destroy
    redirect_to institution_jobs_path(@job.institution.id)
  end


  private


  def save_job
    redirect_to institution_jobs_path(@job.institution.id) if @job.save
  end


  def build_job
    @job ||= job_scope.build
    @job.attributes = job_params
  end


  def load_jobs
    @jobs = job_scope
  end


  def load_job
    @job = job_scope.find(params[:id])
  end


  def job_params
    return {} unless params[:job].present?
    params.require(:job).permit(:id, :title, :description, :requirements, :start_date, :end_date)
  end


  def job_scope
    Institution.find(params[:institution_id]).jobs
  end

end
