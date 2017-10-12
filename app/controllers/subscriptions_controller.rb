class SubscriptionsController < ApplicationController
    load_and_authorize_resource
    
    before_action :get_subscription, only: [:edit, :update, :show]
    before_action :load_job, only:[:new, :create]

    def index
        @subscriptions = subscription_scope
    end

    def new
        @subscription = subscription_scope.build
    end

    def create
        build_subscription
        if @subscription.save
            redirect_to subscription_path(@subscription.id) 
        else
            render(:new, status: :unprocessable_entity)
        end
    end

    def edit
    end

    def update
        respond_to do |format|
            if @subscription.update_attributes(subscription_params) 
                format.html { redirect_to subscription_path(@subscription.id) }
                format.json { render json: @subscription}
            else
                format.html { render(:edit, status: :unprocessable_entity) }
                format.json { render :json => @product.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
    end
    
    private

    def get_subscription
        @subscription = Subscription.find(params[:id])
    end

    def build_subscription
        @subscription ||= subscription_scope.build
        @subscription.attributes = subscription_params
        @subscription.job = @job
        @subscription.user = current_user
    end


    def subscription_params
        return {} unless params[:subscription].present?
        params.require(:subscription).permit(:id, :user_id, :job_id, :status, :cover_letter)
    end

    def subscription_scope
        Job.find(params[:job_id]).subscriptions
    end

    def load_job
        @job = Job.find(params[:job_id])
    end
end
