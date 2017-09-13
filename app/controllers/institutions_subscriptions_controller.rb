class InstitutionsSubscriptionsController < ApplicationController
    before_action :load_institution, :load_subscriptions, only: :index

    def index
        authorize! :read, @subscriptions.first || Subscription
    end

    private

    def load_institution
        @institution = Institution.find(params[:institution_id])
    end
    
    def load_subscriptions
        @subscriptions = subscriptions_scope.joins(:job, :user)
        filter_by_date_start
        filter_by_date_end
        filter_by_search
        order_by_id
    end

    def subscriptions_scope
        @institution.subscriptions
    end

    def filter_by_date_start
        @date_start_str = params[:date_start]
        if @date_start = parse_date(@date_start_str)
            @subscriptions = @subscriptions.where("subscriptions.created_at >= ?", @date_start.at_beginning_of_day)
        end
    end

    def filter_by_date_end
        @date_end_str = params[:date_end]
        if @date_end = parse_date(@date_end_str)
            @subscriptions = @subscriptions.where("subscriptions.created_at <= ?", @date_end.at_end_of_day)
        end
    end

    def parse_date(date_str)
        Date.strptime(date_str, '%d/%m/%Y') 
    rescue 
        nil
    end

    def filter_by_search
        @search = params[:search]
        if params[:search]
            @subscriptions = @subscriptions.where("(jobs.title ILIKE :search or users.name ILIKE :search)", search: "%#{@search}%")
        end
    end

    def order_by_id
        @subscriptions = @subscriptions.order(:id)
    end
end
